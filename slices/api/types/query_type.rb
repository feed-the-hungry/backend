# frozen_string_literal: true

require_relative 'base_object'
require_relative 'feed'
require_relative 'user'

module API
  module Types
    class QueryType < BaseObject
      graphql_name 'Query'

      field :feeds, [Types::Feed], null: true
      field :user, Types::User, null: true do
        argument :id, ID, required: true
      end

      def feeds
        FeedTheHungry::Repositories::FeedRepository.new.all
      end

      def user(id:)
        FeedTheHungry::Repositories::UserRepository.new.find(id)
      end
    end
  end
end
