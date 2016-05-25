require "spec_helper"

describe Kwypper::Application do
  subject { described_class.new }
  let(:request) do
    Kwypper::Request.new do |r|
      r.path = '/test'
      r.http_method = "GET"
    end
  end

  context "#respond_to" do
    it "accepts a request and returns a response"

    it "calls process!"
  
    it "sets the response body"
    
    it "handles not found errors and sets the response status to 404"

    it "handles Exception and sets response status to 500"

    it "handles static file requests"

    it "sets the response content_type for static file requests"
  end
end
