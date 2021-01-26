FROM alpine:3.11

RUN apk update \
    && apk add nodejs npm curl ruby-etc tesseract-ocr ruby-dev build-base \
    && apk add --no-cache ca-certificates 

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile .
RUN gem install bundler
RUN bundle install

COPY . .

ENTRYPOINT ["ruby", "main.rb"]