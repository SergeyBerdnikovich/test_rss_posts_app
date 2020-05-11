# Service for sending request
#
# @arguments:
#   host [String] a target host
#
# @response:
#   response object
#
# @example:
#   response = RequestSender.new("http://localhost:8081").send_request(:get, '/rss_feed_items', urls: ['http://some_rss_feed_url'])
#
class RequestSender
  attr_reader :host

  def initialize(host)
    @host = host
  end

  # Method for sending requests
  #
  # @arguments:
  #   method [Symbol] a http method(:get, :post, etc)
  #   path [String] a resource path
  #   data [Hash] a data which will be sent
  #
  # @response:
  #   response object
  #
  def send_request(method, path, data={})
    headers = data.delete(:headers)

    case method
    when :get
      HTTParty.get("#{host}/#{path}", query: data, headers: headers)
    when :post
      HTTParty.post("#{host}/#{path}", body: data, headers: headers)
    else
      raise NotImplementedError
    end
  end
end
