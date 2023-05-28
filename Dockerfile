FROM ruby:3.2

WORKDIR /srv

COPY Gemfile ./
RUN bundle install

COPY . .

CMD ["bundle", "exec", "rackup --host 0.0.0.0"]
