# Feed The Hungry Backend

[![Build Status](https://travis-ci.org/feed-the-hungry/backend.svg?branch=master)](https://travis-ci.org/feed-the-hungry/backend)
[![codecov](https://codecov.io/gh/feed-the-hungry/backend/branch/master/graph/badge.svg)](https://codecov.io/gh/feed-the-hungry/backend)

This project aims to serve an [GraphQL](https://graphql.org/) API about a RSS feed, which through will be added feed, kinds, categories and fetch entries!

## Setup

### Technologies

This project uses Ruby 2.6, [Hanami](https://hanamirb.org/) and PostgreSQL.

### Docker

I've created a Dockerfile and docker-compose.yml to be better to maintain all
the dependencies.

So, to build the image, you need to run the following command:

```
$ docker-compose build app
```

### Development

How to run tests:

```
% docker-compose run --rm runner bundle exec rake
```

How to run the development console:

```
% docker-compose run --rm runner bundle exec hanami console
```

How to run the development server:

```
% docker-compose up web
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% docker-compose run --rm runner bundle exec hanami db prepare

% docker-compose -e HANAMI_ENV=test run --rm runner bundle exec hanami db prepare
```
