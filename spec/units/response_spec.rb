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
    it "returns a string of the HTTP status code and message" do
      expect(subject.info).to eq "200 Ok"
    end
  end

  context "#headers" do
    it "returns a hash and memoizes it" do
      expect(subject.headers).to be_a Hash
      expect(subject.headers).to be subject.headers
    end
  end

  context "#set_status" do
    it "takes a symbol and sets the HTTP status code and message" do
      subject.set_status :not_found
      expect(subject.code).to eq 404
      expect(subject.message).to eq "Not Found"
    end
  end

  context "#to_http_response" do
    it "outputs the HTTP response string with headers and a nice body" do
      subject.body = "Hello"
      subject.content_type = "text/html"
      expect(subject.to_http_response).to eq    <<-TEXT
HTTP/1.1 200 Ok
Content-Type: text/html

Hello
      TEXT
    end
  end
end
