# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/setup'
require 'hanami/validations'

require_relative '../lib/feed_the_hungry'
require_relative '../apps/api/application'

Hanami.configure do
  mount Api::Application, at: '/'

  mailer do
    root 'lib/feed_the_hungry/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :test do
    logger level: :info, stream: 'log/test.log' if ENV['TEST_LOG']
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
