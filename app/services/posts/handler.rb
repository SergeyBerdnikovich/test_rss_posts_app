# Service for handling(fetching/storing) rss feeds items
#
# @arguments:
#   urls [String, Array<String>, Nil] one or few feed urls whose items need to handle (optional)
#     by default will be used all urls from FeedUrl model (feed_urls table)
#
# @response:
#   errors [String] a concatenated errors of fetching feed items
#
class Posts::Handler
  attr_reader :errors

  def initialize(urls=nil)
    @feed_urls  = Array.wrap(urls).presence || FeedUrl.all.pluck(:url)
    @posts_data = []
    @errors     = ''
  end

  def call
    fetch_posts
    store_posts
  end

  private

  attr_reader :feed_urls, :posts_data

  def fetch_posts
    @posts_data, @errors = posts_fetcher.fetch_posts
  end

  def store_posts
    posts_creator.create_new_posts
  end

  def posts_fetcher
    @posts_fetcher ||= Posts::Fetcher.new(feed_urls)
  end

  def posts_creator
    @posts_creator ||= Posts::Creator.new(posts_data)
  end
end
