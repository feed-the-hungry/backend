# frozen_string_literal: true

require_relative 'base_object'
require_relative 'feed'

module Types
  class QueryType < Types::BaseObject
    graphql_name 'Query'

    field :feeds, [Types::Feed], null: true

    def feeds
      FeedRepository.new.all
    end
  end
end
