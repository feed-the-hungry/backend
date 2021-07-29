# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require 'hanami/validations'

require_relative './initializers/locale.rb'

require_relative '../lib/feed_the_hungry'
require_relative '../apps/api/application'

Hanami.configure do
  mount Api::Application, at: '/'
  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/feed_the_hungry_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/feed_the_hungry_development'
    #    adapter :sql, 'mysql://localhost/feed_the_hungry_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/feed_the_hungry/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery(
        :smtp,
        address: ENV.fetch('SMTP_HOST'),
        port: ENV.fetch('SMTP_PORT')
      )
    end
  end
end
