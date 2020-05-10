# == Schema Information
#
# Table name: feed_urls
#
#  id  :bigint           not null, primary key
#  url :string
#
class FeedUrl < ApplicationRecord
  after_commit :fetch_and_create_posts, on: [:create, :update]

  private

  def fetch_and_create_posts
    FetchPostsJob.perform_later(self.url)
  end
end
