require 'socket'
module Kwypper
  class HttpServer < TCPServer

    def initialize(port)
      @port = port
      super
    end

    def serve
      parser = HttpParser.new
      log("Listening on port #{@port}")
      begin
        while socket = accept
          request = parser.parse socket
          app = Kwypper::Application.new
          response = app.respond_to request

          socket.write response.to_http_response
          socket.close
        end
      rescue Interrupt
        log("Bye")
      end

    end

    def log(message)
      STDOUT.puts "[#{Time.now}] #{message}"
    end
  end
end
