FROM ruby:2.6-alpine

ENV BUILD_DEPENDENCIES "build-base git postgresql-dev postgresql-client tzdata bind-tools"

# Minimal requirements to run our backend and tests
RUN apk update && apk add --no-cache --update $BUILD_DEPENDENCIES \
    rm -rf /var/cache/apk/*.tar.gz

COPY Gemfile* /tmp/
WORKDIR /tmp

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3 --without production \
    && rm -rf $BUNDLE_PATH/cache/*.gem

ENV APP_PATH /app

# Different layer for gems installation
WORKDIR $APP_PATH

# Copy the application into the container
COPY . $APP_PATH
