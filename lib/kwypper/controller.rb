module Kwypper
  class Controller
    attr_reader :action, :request_params

    def self.add_routes(route_hash)
      route_hash.each do |info, action_name|
        routes.merge! info => [self, action_name]
      end
    end

    def self.routes
      @@routes ||= {}
    end

    add_routes "GET /home" => :home

    def self.layout(name=nil)
      name ? @@layout = name : @@layout
    end

    def initialize (request)
      @request_params ||= request.params.map{|param| param.split('=')}
    end

    def process(value)
      @action = value
      send @action
    end

    def home
      @data = {test: 'awesome'}
      render :home
    end

    def params
      param_hash = Hash[request_params]
      @params = param_hash.inject({}) do |memo,(k,v)|
        memo[k.to_sym] = v
        memo
      end
    end

    protected

    def render(view_name)
      view_path = File.join(Dir.pwd, "app/views", "#{view_name}.erb")
      template = File.read view_path
      ERB.new(template).result binding
    end

  end
end