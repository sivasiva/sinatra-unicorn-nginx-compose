FROM ruby:2.7.3
WORKDIR /app
COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install

