FROM ruby:3.2

WORKDIR /srv

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY config.ru ./

CMD ["bundle", "exec", "rackup --host 0.0.0.0"]
