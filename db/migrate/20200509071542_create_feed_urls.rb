class CreateFeedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :feed_urls do |t|
      t.string :url
    end
  end
end
