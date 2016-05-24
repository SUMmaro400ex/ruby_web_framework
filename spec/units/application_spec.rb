require "spec_helper"

describe Kwypper::Application do
  subject { described_class.new }
  let(:request) do
    Kwipper::Request.new do |r|
      r.path = '/test'
      r.htp_method = "GET"
    end
  end

  context "#respond_to" do
    it "accepts a request and returns a response"

    it "calls process!"

    it "handles not found errors and sets the response status to 404"

    it "handles Exception and sets response status to 500"

    it "sets the view and the response body"

    it "handles static file requests"

    it "sets the correct mime type for static file requests"
  end
end
