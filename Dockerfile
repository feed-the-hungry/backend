# | base
FROM ruby:3.1.4-alpine3.18 as base

# Minimal requirements to run our backend and tests
RUN apk add --no-cache --update build-base git postgresql-dev postgresql-client tzdata && \
    rm -rf /var/cache/apk/*.tar.gz

ENV APP_NAME fth-backend
ENV APP_ROOT /app

WORKDIR $APP_ROOT

COPY . .

# | bundle
FROM base as bundle

ARG BUNDLE_WITHOUT_GROUPS
ARG BUNDLE_IS_PRD

RUN gem install --default bundler:2.4.6 && \
    gem update --system && \
    bundle update --bundler && \
    bundle config set deployment ${BUNDLE_IS_PRD} && \
    [[ -z "${BUNDLE_WITHOUT_GROUPS}" ]] && bundle config set without ${BUNDLE_WITHOUT_GROUPS} || echo '' && \
    bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3 && \
    rm -rf $BUNDLE_PATH/cache/*.gem

# | backend
FROM base as backend

RUN mkdir -p $APP_ROOT/tmp/pids

COPY --from=bundle $APP_ROOT $APP_ROOT
COPY --from=bundle /usr/local/bundle/config /usr/local/bundle/config

CMD bundle exec puma -C config/puma.rb
