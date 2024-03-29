# frozen_string_literal: true

require_relative 'base_object'
require_relative 'date_time'
require_relative 'email'

module API
  module Types
    class User < BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :email, Types::Email, null: false
      field :created_at, Types::DateTime, null: false
      field :updated_at, Types::DateTime, null: false
      field :feeds, Types::Feed.connection_type, null: true, connection: true

      def feeds
        FeedTheHungry::Repositories::UserFeedRepository
          .new
          .feeds_from_user(object)
      end
    end
  end
end
