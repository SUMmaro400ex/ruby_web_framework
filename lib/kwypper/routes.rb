module Kwypper
  class Routes

    GET_VERB = "GET".freeze
    POST_VERB = "POST".freeze
    def self.resources(resource)
      @@controller_class = resource.to_s
      resources_views.each do |method|
        parse_class_name.send(:add_routes, "GET /#{@@controller_class}/#{method}" => method.to_sym)
      end
    end

    def self.get(route_hash)
      single_route(route_hash, GET_VERB)
    end

    def self.post(route_hash)
      single_route(route_hash, POST_VERB)
    end

    def self.root(controller_route)
      parse_controller_route(controller_route)
      parse_class_name.send(:add_routes, "GET " => @@controller_method)
    end

    private

    def self.single_route(route_hash, verb)
      parse_controller_route(route_hash.values.first)
      add_route(route_hash.keys.first, verb)
    end

    def self.add_route(route, verb)
      parse_class_name.send(:add_routes, "#{verb} #{route}" => @@controller_method.to_sym)
    end

    def self.parse_controller_route(controller_route)
      @@controller_class, @@controller_method = "#{controller_route}".split("#")
    end

    def self.resources_views
      ["index", "new", "edit", "show"]
    end

    def self.parse_class_name
      resource_class = @@controller_class.split('_').map(&:capitalize).join(',')
      Object.const_get("Controllers::#{resource_class}Controller")
    end
  end
end