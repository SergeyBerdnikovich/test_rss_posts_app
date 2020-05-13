class Publisher
  def self.publish(routing_key, message = {})
    exchange = channel.default_exchange

    exchange.publish(message.to_json, routing_key: routing_key)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new(ENV['RABBIT_MQ_URL']).tap do |c|
      c.start
    end
  end
end
