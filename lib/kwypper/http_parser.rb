require 'rack'
module Kwypper
  class EmptyRequestError < RuntimeError; end

  class HttpParser
    def parse(request_socket)
      @first_line = request_socket.gets or raise EmptyRequestError
      Request.new do |r|
        r.http_method = @first_line.split.first
        r.path = parse_path
        r.headers = parse_headers request_socket
        r.cookies = parse_cookies r.headers["COOKIE"]
        r.content_length = r.headers['CONTENT_LENGTH'].to_i
        if r.content_length > 0
          r.post_data = read_body request_socket, r.content_length
        end
      end
    end

    def parse_path
      @first_line.split(' ')[1].split('?')[0]
    end

    def parse_headers(raw_request)
      request_headers = {}

      while (line = raw_request.gets) != "\r\n"
        key, val = line.split(/:\s/)
        key = key.to_s.upcase.tr('-', '_')
        request_headers[key] = val.to_s.chomp
      end

      request_headers
    end

    def parse_cookies(cookie_value)
      pairs = cookie_value.to_s.split(/;\s?/)
      tuples = pairs.map { |c| c.split '=' }
      Hash[tuples]
    end

    def read_body(raw_request, content_length)
      ::Rack::Utils.parse_nested_query(raw_request.read(content_length))
    end
  end
end
