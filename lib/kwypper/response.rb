module Kwypper
  class Response
    attr_accessor :body, :code, :content_type, :message

    def self.statuses
      {
          ok: [200, "Ok"],
          not_found: [404, "Not Found"],
          server_error: [500, "Server Error"]
      }
    end

    def initialize(request=nil)
      set_status(:ok)
    end

    def headers
      @headers ||= {}
    end

    def set_status(status)
      @status = self.class.statuses[status]
      @code, @message = @status
    end

    def content_type=(type)
      @content_type = type
      headers["Content-Type"] = type
      type
    end

    def to_http_response
     <<-TEXT
HTTP/1.1 #{info}
#{serialize_headers}

#{body}
      TEXT
    end

    def info
      "#{@status[0]} #{@status[1]}"
    end

    private

    def serialize_headers
      headers.each_with_object("") do |(key, val), serialized|
        serialized << "#{key}: #{val}"
      end
    end

  end
end
