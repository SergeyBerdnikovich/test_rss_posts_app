class NewFeedItemsWorker
  include Sneakers::Worker

  from_queue 'rss.feed_items', env: nil

  def work(raw_data)
    parsed_data = JSON.parse(raw_data)

    # parsed_data['errors'] # need to show this data on UI,
    # we can refactor this part to respond with [{'errros' => {'feed_url' => 'some feed url', 'message' => 'Some message'}]}
    # and store this data to DB or push it through websocket...

    Posts::Creator.new(parsed_data['items']).create_new_posts
    ack!
  end
end
