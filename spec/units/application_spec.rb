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
    it "accepts a request and returns a response" do
      expect(subject).to receive(:respond_to).with(request).and_return Kwypper::Response.new
      expect(subject.respond_to(request)).to be_a Kwypper::Response
    end

    it "calls process!" do
      expect(subject).to receive(:process!)
      subject.respond_to request
    end
  
    it "sets the response body" do
      response = subject.respond_to(request)
      expect(response.body).to_not be nil
    end
    
    it "handles not found errors and sets the response status to 404" do
      request = Kwypper::Request.new do |r|
        r.path = '/non-existent'
        r.http_method = "GET"
      end
      response = subject.respond_to(request)
      expect(response.code).to eq 404
    end

    it "handles Exception and sets response status to 500" do
      request = Kwypper::Request.new do |r|
        r.path = '/error'
        r.http_method = "GET"
      end
      response = subject.respond_to(request)
      expect(response.body).to eq "Server Error"
      expect(response.code).to eq 500
    end

    it "handles static file requests" do
      request = Kwypper::Request.new do |r|
        r.path = '/test.txt'
      end
      expect(subject.respond_to(request).body).to eq "Testing\n"
    end

    it "sets the response content_type for static file requests" do
      request = Kwypper::Request.new do |r|
        r.path = '/test.txt'
      end
      response = subject.respond_to(request)
      expect(response.content_type).to eq "text/plain"
    end
  end
end
