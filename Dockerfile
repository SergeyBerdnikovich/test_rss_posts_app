FROM ruby:2.6.3
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && apt-get install -y nodejs postgresql-client vim cron && \
  apt-get install -y yarn
RUN mkdir /myapp
WORKDIR /myapp

ENV BUNDLE_BUILD__SASSC=--disable-march-tune-native
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=2d92262c2464ba2e2fe1f2b9050af16792091e48f1d4b3b7af9b0d4d6534a938df41d48870ebed7f1419f0625537434062461444f0811eb208e3da17377def55

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --without development test

COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock
COPY . /myapp

RUN rm -rf node_modules
RUN rails assets:clobber
RUN yarn install --check-files
RUN rails assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
