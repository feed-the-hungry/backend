require 'hanami/interactor'

require 'rss'

module FeedTheHungry
  module Interactors
    module Entries
      module Parser
        def self.call(feed)
          URI.parse(feed.url).open do |content|
            parsed_content = RSS::Parser.parse(content)

            parsed_content.items.map do |item|
              {
                feed_id: feed.id,
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
end
