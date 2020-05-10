require 'sidekiq/web'
require 'sidekiq/cron/web'

Sidekiq.configure_client do |config|
  redis_url = if Rails.env.production?
                ENV['REDIS_URL']
              else
                Rails.application.config.sidekiq[:redis_url]
              end

  config.redis = { url: redis_url }
end

Sidekiq.configure_server do |config|
  redis_url = if Rails.env.production?
                ENV['REDIS_URL']
              else
                Rails.application.config.sidekiq[:redis_url]
              end

  config.redis = { url: redis_url }
end

schedule_file = "config/schedule.yml"
if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end
