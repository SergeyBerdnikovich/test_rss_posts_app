<h5>A test application for handling rss posts for https://www.emerchantpay.com</h5>

<h2>What we are using in this project:</h2>
ruby version is 2.6.3
rails version is 6.0.3
postgresql as database
sidekiq for background jobs

<h3>The application is communicates with rss service via http</h3>

<h2>How to run the app:</h2>
create database: <code>rails db:create</code>
run migrations: <code>rails db:migrate</code>
start sidekiq: <code>bundle exec sidekiq</code>
start server: <code>rails s</code>

for tests tun: <code>rspec</code>
note that for integration tests you need to have rss service to be run
