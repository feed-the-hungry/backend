# frozen_string_literal: true

require_relative '../validators/http_uri_validator'

module FeedTheHungry
  module Contracts
    class EntryContract < Base
      params do
        required(:feed_id).filled(:string)
        required(:guid).filled(:string)
        required(:title).filled(:string)
        required(:description).filled(:string)
        required(:published_at).filled(:time)
      end

      rule :guid do
        key.failure(:url?) unless FeedTheHungry::Validators::HttpUriValidator.valid?(value)
      end
    end
  end
end
