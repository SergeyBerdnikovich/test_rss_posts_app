# Service for sending request
#
# @arguments:
#   host [String] a target host
#
# @response:
#   [String] some result data
#
# @example:
#   response = RequestSender.new("http://localhost:8081").send_request(:get, '/rss_feed_items', urls: ['http://some_rss_feed_url'])
#
class RequestSender
  attr_reader :host

  def initialize(host)
    @host = host
  end

  def send_request(method, path, data={})
    case method
    when :get
      HTTParty.get("#{host}/#{path}", query: data).body
    else
      raise NotImplementedError
    end
  end
end
