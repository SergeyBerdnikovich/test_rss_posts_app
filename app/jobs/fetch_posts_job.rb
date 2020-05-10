# A background job which handles rss posts
#
# @arguments
#   urls [Array<String>, Array<Nil>, Nil] array of feed urls
#
class FetchPostsJob < ApplicationJob
  queue_as :fetch_posts

  def perform(urls)
    Posts::Handler.new(urls).call
  end
end
