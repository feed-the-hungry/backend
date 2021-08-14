require_relative './http_uri_validator'

module FeedTheHungry
  module Validators
    class EntryValidator
      include Hanami::Validations

      messages :i18n

      predicate :url? do |current|
        FeedTheHungry::Validators::HttpUriValidator.valid?(current)
      end

      validations do
        required(:feed_id) { filled? & str? }
        required(:guid) { filled? & str? & url? }
        required(:title) { filled? & str? }
        required(:description) { filled? & str? }
        required(:published_at) { filled? & time? }
      end
    end
  end
end
