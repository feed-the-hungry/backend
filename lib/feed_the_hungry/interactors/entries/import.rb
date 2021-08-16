# frozen_string_literal: true

require 'hanami/interactor'

module FeedTheHungry
  module Interactors
    module Entries
      class Import
        include Hanami::Interactor

        def call
          repository = FeedRepository.new

          repository.all.each do |feed|
            parsed_entries = Parser.call(feed)

            parsed_entries.each do |attributes|
              result = AddEntry.new.call(attributes)

              next if result.successful?

              log_issue_to_import_entries!(attributes[:guid], feed.url)
            end
          end
        end

        private

        def log_issue_to_import_entries!(guid, feed_url)
          Hanami.logger&.info(
            "[FTH][FEED_IMPORT] The entry #{guid} for #{feed_url} can't be imported"
          )
        end
      end
    end
  end
end
