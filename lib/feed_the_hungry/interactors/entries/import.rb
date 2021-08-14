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

              unless result.successful?
                Hanami.logger.info(
                  "[FTH][FEED_IMPORT] The entry #{attributes[:guid]} for #{feed.url} can't be imported"
                )
              end
            end
          end
        end
      end
    end
  end
end
