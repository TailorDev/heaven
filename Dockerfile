FROM ruby:2.3-alpine
MAINTAINER William Durand <will+git@drnd.me>

 RUN apk update && apk --update add \
     # required for Heaven app
     postgresql-client tzdata libxml2-dev libxslt-dev \
     # required during deployments
     git nodejs bash build-base autoconf python automake rsync nasm openssh && \
     rm -rf /var/cache/apk/*

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies \
    ruby-dev postgresql-dev libc-dev linux-headers && \
    cd /app ; bundle install --without development test && \
    apk del build-dependencies

ADD . /app
RUN addgroup heaven && \
    adduser -D -H -G heaven heaven && \
    chown -R heaven:heaven /app
USER heaven

ENV RAILS_ENV production
ENV RACK_ENV production
ENV REDIS_PROVIDER REDIS_URL
ENV HEAVEN_ENV 1

WORKDIR /app

EXPOSE 8080

CMD ["bundle", "exec", "unicorn", "-p", "8080", "-c", "./config/unicorn.rb"]
