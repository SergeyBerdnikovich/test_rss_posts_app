# == Schema Information
#
# Table name: feed_urls
#
#  id  :bigint           not null, primary key
#  url :string
#
class FeedUrl < ApplicationRecord
  # after_commit :fetch_and_create_posts, on: [:create, :update]
  after_commit :push_create_or_update_url, on: [:create, :update]

  private

  def fetch_and_create_posts
    FetchPostsJob.perform_later(self.url)
  end

  def push_create_or_update_url
    Publisher.publish('rss.feed_urls', self.url)
  end
end
