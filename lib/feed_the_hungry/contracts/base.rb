# frozen_string_literal: true

module FeedTheHungry
  module Contracts
    class Base < Dry::Validation::Contract
      config.messages.backend = :i18n

      config.messages.top_namespace = :feed_the_hungry

      config.messages.load_paths << 'config/locales/en.yml'
    end
  end
end
