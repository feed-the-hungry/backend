# frozen_string_literal: true

require 'hanami/interactor'

require 'rss'

module FeedTheHungry
  module Interactors
    module Entries
      module Parser
        class << self
          def call(feed)
            URI.parse(feed.url).open do |content|
              parsed_content = RSS::Parser.parse(content)

              parsed_content.items.map { |item| item_output(feed.id, item) }
            end
          end

          private

          def item_output(feed_id, item)
            {
              feed_id: feed_id,
              guid: item.guid.content,
              title: item.title,
              description: item.description,
              published_at: item.pubDate
            }
          end
        end
      end
    end
  end
end
