require "spec_helper"

describe Kwypper::Response do
  subject do
    request = Kwypper::Request.new do |r|
      r.path = '/test'
      r.http_method = "GET"
    end
    described_class.new request
  end

  context "#info" do
    it "returns a string of the HTTP status code and message"
  end

  context "#headers" do
    it "returns a hash and memoizes it"
  end

  context "#set_status" do
    it "takes a symbol and sets the HTTP status code and message"
  end

  context "#to_http_response" do
    it "outputs the HTTP response string with headers and a nice body"
  end
end
