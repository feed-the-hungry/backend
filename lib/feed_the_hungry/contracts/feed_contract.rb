# frozen_string_literal: true

require 'feed_validator'

require_relative '../validators/http_uri_validator'

module FeedTheHungry
  module Contracts
    class FeedContract < Base
      params do
        required(:title).filled(:string)
        required(:url).filled(:string)
        required(:kind).filled(:string)
      end

      rule :url do
        if FeedTheHungry::Validators::HttpUriValidator.valid?(value)
          feed_validator = FeedValidator.new(value).call

          key.failure(:feed_url?) unless feed_validator.valid?
        end
      end
    end
  end
end
