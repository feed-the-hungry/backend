# frozen_string_literal: true

module FeedTheHungry
  module Workers
    module Feeds
      class EntryImporter
        include Sidekiq::Worker

        def perform
          FeedTheHungry::Interactors::Entries::Import.new.call
        end
      end
    end
  end
end
