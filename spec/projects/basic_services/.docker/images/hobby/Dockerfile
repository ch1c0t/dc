FROM ruby:2.5-alpine

RUN apk update && apk add --no-cache build-base
RUN gem i bundler hobby puma redis

ONBUILD ADD . /app
ONBUILD RUN cd /app; bundle install
ONBUILD RUN chown -R nobody:nogroup /app

ADD main.rb /
CMD ["ruby", "main.rb"]
