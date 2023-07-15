# frozen_string_literal: true

module FeedTheHungry
  module Persistence
    module Relations
      class Entries < ROM::Relation[:sql]
        schema(:entries, infer: true) do
          associations do
            belongs_to :feed
          end
        end
      end
    end
  end
end
