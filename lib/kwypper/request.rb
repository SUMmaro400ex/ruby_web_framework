class Request
  attr_accessor :post_data, :http_method, :path, :headers, :query, :post_data, :cookies, :content_length
  def initialize
    @post_data = {}
    @headers = {}
    @cookies = {}
    @content_length = 0
    yield self if block_given?
  end

  def info
    http_method + " " + path
  end

  def params
    query.merge post_data
  end
end
