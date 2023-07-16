# frozen_string_literal: true

require 'rom'

module FeedTheHungry
  module Persistence
    def self.db
      @db ||= ROM.container(configuration)
    end

    def self.relations
      db.relations
    end

    def self.configuration
      @configuration ||= ROM::Configuration.new(:sql, ENV.fetch('DATABASE_URL')).tap do |config|
        config.auto_registration(Hanami.root.join('lib/feed_the_hungry/persistence'),
                                 namespace: 'FeedTheHungry::Persistence')
      end
    end
  end
end
