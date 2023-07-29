# frozen_string_literal: true

require 'sidekiq'

module FeedTheHungry
  module Workers
    module Feeds
      class EntryImporterWorker
        include ::Sidekiq::Worker

        sidekiq_options queue: :scheduler

        def perform
          FeedTheHungry::Interactors::Entries::Import.new.call
        end
      end
    end
  end
end
