# frozen_string_literal: true

require_relative 'repository'

module FeedTheHungry
  module Repositories
    class UserRepository < Repository[:users]
      include ExistHelper

      def email_exist?(email: nil)
        exist?(field: :email, value: email, collection: users)
      end

      def add_feed(user, feed)
        assoc(:feeds, user).add(feed)
      end
    end
  end
end
