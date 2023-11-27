# syntax=docker/dockerfile:1
FROM ruby:3.2
WORKDIR /srv
COPY Gemfile Gemfile.lock config.ru ./
RUN bundle

CMD ["bundle", "exec", "rackup --host 0.0.0.0"]
