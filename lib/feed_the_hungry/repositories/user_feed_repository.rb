# frozen_string_literal: true

require_relative 'repository'

module FeedTheHungry
  module Repositories
    class UserFeedRepository < Repository[:user_feeds]
      def feeds_from_user(user)
        user_feeds
          .where(user_id: user.id)
          .feeds
          .order(feeds[:created_at].qualified)
          .map
          .to_a
      end
    end
  end
end
