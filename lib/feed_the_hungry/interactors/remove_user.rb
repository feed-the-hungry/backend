# frozen_string_literal: true

module FeedTheHungry
  module Interactors
    class RemoveUser
      include Interactors::Base

      expose :user

      def initialize(repository: FeedTheHungry::Repositories::UserRepository.new)
        @repository = repository
      end

      def call(id)
        @user = repository.delete(id)

        self
      end

      private

      attr_reader :repository
    end
  end
end
