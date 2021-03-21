ARG BASE=ruby:2.6.6

FROM ruby:2.6.6 as base

RUN bundle config --global frozen 1
RUN bundle config set without "development test"

RUN apt-get update
RUN apt-get install -y imagemagick

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install && bundle clean --force
EXPOSE 4567

CMD ["bundle", "exec", "ruby", "app.rb"]