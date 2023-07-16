# frozen_string_literal: true

module FeedTheHungry
  module Persistence
    module Relations
      class Users < ROM::Relation[:sql]
        schema(:users, infer: true) do
          associations do
            has_many :user_feeds
            has_many :feeds, through: :user_feeds
          end
        end
      end
    end
  end
end
