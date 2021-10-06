source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 6.0.3'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'administrate', '~> 0.13.0'
gem 'httparty', '~> 0.18.0'
gem 'activerecord-import', '~> 1.0.4'
gem 'sidekiq', '~> 6.2.1'
gem 'sidekiq-failures', '~> 1.0.0'
gem 'sidekiq-statistic', '~> 1.4.0'
gem 'sidekiq-cron', '~> 1.1'
gem 'slim', '~> 4.1.0'
gem 'bunny', '>= 2.14.1'
gem 'sneakers', '~> 2.11.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'annotate', '~> 3.1.0', require: false # annotate --exclude tests,fixtures --position before --sort
  gem 'rspec-rails', '~> 4.0.0'
  gem 'pry'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_cleaner', '>= 1.8.3'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'vcr', '~> 3.0.3'
  gem 'webmock', '~> 3.8.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
