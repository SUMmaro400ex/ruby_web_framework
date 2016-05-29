require 'mime-types'
require 'erb'
require 'pp'
require 'pry'

Dir[File.expand_path('kwypper/*', File.dirname(__FILE__))].each { |file| require file }
Dir[File.expand_path('../app/controllers/*', File.dirname(__FILE__))].each { |file| require file }
Dir[File.expand_path('../config/*', File.dirname(__FILE__))].each { |file| require file }


module Kwypper
  module_function
  def run
    HttpServer.new(9000).serve
  end
end

Kwypper.run if $0 ==  __FILE__
