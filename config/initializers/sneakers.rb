Sneakers.configure(log: STDOUT, amqp: ENV['RABBIT_MQ_URL'])
Sneakers.logger.level = Logger::INFO
