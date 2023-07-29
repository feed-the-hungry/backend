# frozen_string_literal: true

require_relative 'add_feed_to_user'

module FeedTheHungry
  module Interactors
    class AddFeed
      include Interactors::Base
      include AddFeedToUser

      expose :feed

      def initialize(repository: FeedTheHungry::Repositories::FeedRepository.new,
                     user_repository: FeedTheHungry::Repositories::UserRepository.new)
        @repository = repository
        @user_repository = user_repository
      end

      def call(attributes)
        result = FeedTheHungry::Contracts::FeedContract.new.call(attributes)

        if result.success?
          @feed = create_or_return_feed(attributes)

          add_feed_to_user!(@feed, attributes[:user_id])
        else
          error_messages(result)
        end

        self
      end

      private

      attr_reader :repository, :user_repository

      def create_or_return_feed(attributes)
        url = attributes[:url]

        if repository.url_exist?(url:)
          repository.find_by_url(url)
        else
          repository.create(attributes)
        end
      end
    end
  end
end
