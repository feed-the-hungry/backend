# frozen_string_literal: true

module FeedTheHungry
  module Persistence
    module Relations
      class UserFeeds < ROM::Relation[:sql]
        schema(:user_feeds, infer: true) do
          associations do
            belongs_to :user
            belongs_to :feed
          end
        end
      end
    end
  end
end
