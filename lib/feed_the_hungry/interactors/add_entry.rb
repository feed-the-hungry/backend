# frozen_string_literal: true

module FeedTheHungry
  module Interactors
    class AddEntry
      include Interactors::Base

      expose :entry

      def initialize(repository: FeedTheHungry::Repositories::EntryRepository.new)
        @repository = repository
      end

      def call(attributes)
        result = FeedTheHungry::Contracts::EntryContract.new.call(attributes)

        if result.success?
          @entry = repository.create(attributes)
        else
          error_messages(result)
        end

        self
      end

      private

      attr_reader :repository
    end
  end
end
