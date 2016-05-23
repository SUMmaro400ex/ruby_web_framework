Dir[File.expand_path('kwypper/*', File.dirname(__FILE__))].each { |file| require file }
require 'rack'

module Kwypper
  module_function
  def run
    HttpServer.new(9000).serve
  end
end
