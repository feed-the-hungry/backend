# frozen_string_literal: true

module FeedTheHungry
  module Persistence
    module Relations
      class Feeds < ROM::Relation[:sql]
        schema(:feeds, infer: true) do
          associations do
            has_many :users, through: :user_feeds

            has_many :entries
          end
        end
      end
    end
  end
end
