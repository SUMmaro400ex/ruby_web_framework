module Kwypper
  class Application
    attr_reader :request
    def respond_to(request)
      @request = request
      puts @request.info
      @response = Kwypper::Response.new
      begin
        process!
      rescue => e
        @response.body = "Server Error"
        @response.code = 500
      end
      @response
    end

    def process!
      if Kwypper::Controller.routes.key? request.info
        controller_class, action = Kwypper::Controller.routes[request.info]
        controller = controller_class.new request
        @response.body = controller.process action
      elsif is_static_file_request?
        @response.body = File.read(get_file)
        @response.content_type = get_content_type
      else
        @response.body = "<h1>something</h1>"
        @response.code = 404
        raise "hell" if @request.path == "/error"
      end
    end

    private

    def is_static_file_request?
      File.exists?(get_file) && !File.directory?(get_file)
    end

    def get_file
      File.join(Dir.pwd, "public", @request.path)
    end

    def get_content_type
      mime = MIME::Types.of(get_file)
      mime.content_type if mime
    end
  end
end