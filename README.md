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

<h2>For running via Docker:</h2>
You need to run <code>docker-compose up -d</code>
an example of config file is located in <code>test_rss_posts_app/docker-compose.yml</code>
also you need to have <code>.env</code> file
The images of services already builded and located in docker hub but you can manually build them, <code>Dockerfile</code> is located inside each of the projects
