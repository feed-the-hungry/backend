# frozen_string_literal: true

require 'feed_validator'

require_relative './http_uri_validator'

module FeedTheHungry
  module Validators
    class FeedValidator
      include Hanami::Validations

      messages :i18n

      predicate :feed_url? do |current|
        feed_validator = W3C::FeedValidator.new
        feed_validator.validate_url(current)
        feed_validator.valid?
      end

      predicate :url? do |current|
        FeedTheHungry::Validators::HttpUriValidator.valid?(current)
      end

      validations do
        required(:title) { filled? & str? }
        required(:url) { filled? & str? & url? & feed_url? }
        required(:kind) { filled? & str? & included_in?(FeedKind.all) }
      end
    end
  end
end
