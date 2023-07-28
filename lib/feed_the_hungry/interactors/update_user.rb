# frozen_string_literal: true

module FeedTheHungry
  module Interactors
    class UpdateUser
      include Interactors::Base

      expose :user

      def initialize(repository: FeedTheHungry::Repositories::UserRepository.new)
        @repository = repository
      end

      def call(id, attributes)
        result = FeedTheHungry::Contracts::UserContract.new.call(attributes)

        email_exist = repository.email_exist?(email: attributes[:email])

        if result.success? && !email_exist
          @user = repository.update(id, attributes)
        else
          error_messages(result)

          unique_error(:email, attributes[:email]) if email_exist
        end

        self
      end

      private

      attr_reader :repository
    end
  end
end
