# frozen_string_literal: true

require_relative '../repository'

module FeedTheHungry
  module Repositories
    class UserRepository < Repository[:users]
      commands :create,
               update: :by_pk,
               use: :timestamps,
               plugins_options: { timestamps: { timestamps: %i[created_at updated_at] } }

      def email_exist?(email: nil)
        exist?(field: :email, value: email)
      end

      def add_feed(user, feed)
        UserFeedRepository.new.create(user_id: user.id, feed_id: feed.id)
      end
    end
  end
end
