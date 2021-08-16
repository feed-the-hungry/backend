# frozen_string_literal: true

require_relative 'base_object'
require_relative 'feed'
require_relative 'user'

module Types
  class QueryType < Types::BaseObject
    graphql_name 'Query'

    field :feeds, [Types::Feed], null: true
    field :user, Types::User, null: true do
      argument :id, ID, required: true
    end

    def feeds
      FeedRepository.new.all
    end

    def user(id:)
      UserRepository.new.find(id)
    end
  end
end
