# Service for fetching feeds items
#
# @arguments:
#   urls [Array<String>] array of feed urls
#
# @response:
#   posts [Array<Hash>] array of fetched feeds items
#     example:
#       [
#         {
#           "title"        => "Some Title",
#           "source"       => "Some Source",
#           "source_url"   => "http://soem_source_url",
#           "link"         => "http://some_link",
#           "publish_date" => "2020-05-09 12:45",   # can be nil
#           "description"  => "Some Description"
#         },
#         ...
#       ]
#
#   errors [String] a concatenated errors of fetching feed items
#
class Posts::Fetcher
  RSS_SERVICE_HOST    = 'http://localhost:8081'.freeze
  RSS_FEED_ITEMS_PATH = '/rss_feeds_items'.freeze

  attr_reader :urls
  attr_reader :posts, :errors

  def initialize(urls)
    @urls = urls
  end

  def fetch_posts
    response = request_sender.send_request(:get, RSS_FEED_ITEMS_PATH, urls: urls)
    parsed_response = JSON.parse(response)

    @posts  = parsed_response['items']
    @errors = parsed_response['errors']

    [@posts, @errors]
  end

  private

  def request_sender
    @request_sender ||= ::RequestSender.new(Rails.application.config.services[:rss_service][:host])
  end
end
