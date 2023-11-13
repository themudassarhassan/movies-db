FROM ruby:3.2.2-alpine

ENV BUNDLER_VERSION=2.4.11

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \ 
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      openssl \
      pkgconfig \
      postgresql-dev \
      tzdata \
      gcompat

RUN gem install bundler -v 2.4.11

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install 

COPY . ./

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0"]
