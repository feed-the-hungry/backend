# frozen_string_literal: true

module FeedTheHungry
  module Contracts
    class UserContract < Base
      params do
        required(:name).filled(:string)
        required(:email).filled(:string)
      end

      rule :email do
        key.failure(:invalid) unless FeedTheHungry::EMAIL_REGEX.match?(value)
      end
    end
  end
end
