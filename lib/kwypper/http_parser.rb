require 'rack'
module Kwypper
  class EmptyRequestError < RuntimeError; end

  class HttpParser
    attr_reader :raw_request, :first_line
    CARRIAGE_RETURN = "\r\n".freeze

    def parse(request_socket)
      @raw_request = request_socket
      @first_line = request_socket.gets or raise EmptyRequestError
      req = Request.new do |r|
        r.http_method = http_method
        r.path = path
        r.params = params
        r.headers = headers
        r.content_length = content_length
        r.post_data = read_body if content_length > 0
        r.cookies = parse_cookies
      end
      req
    end

    private

    def http_method
      @http_method ||= first_line.split.first
    end

    def path
      path_params_splitter[0].chomp('/')
    end

    def params
      path_params_splitter[1] ? path_params_splitter[1].split('&') : []
    end

    def path_params_splitter
      first_line.split(' ')[1].split('?')
    end

    def headers
      @header ||= parse_headers
    end

    def parse_headers
      set_lines
      lines.each_with_object({}) do |line, request_headers|
        key, val = line.split(/:\s/)
        request_headers[key] = val.to_s.chomp
      end
    end

    def lines
      @lines ||= []
    end

    def set_lines
      while (line = raw_request.gets) != CARRIAGE_RETURN
        lines << line.chomp
      end
    end

    def content_length
      @content_length ||= headers['Content-length'].to_i
    end

    def read_body
      ::Rack::Utils.parse_nested_query(raw_request.read(content_length))
    end

    def parse_cookies
      Hash[cookie_tuple]
    end

    def cookie_pairs
      @cookie_pairs ||= headers["COOKIE"].to_s.split(/;\s?/)
    end

    def cookie_tuple
      @cookie_tuple ||= cookie_pairs.map { |c| c.split '=' }
    end
  end
end
