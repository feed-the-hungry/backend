# frozen_string_literal: true

require 'uri'
require 'feed_validator'

class FeedValidator
  include Hanami::Validations

  messages :i18n

  HTTP_FORMAT = URI::DEFAULT_PARSER.make_regexp(%w[http https])

  predicate :feed_url? do |current|
    feed_validator = W3C::FeedValidator.new
    feed_validator.validate_url(current)
    feed_validator.valid?
  end

  validations do
    required(:title) { filled? & str? }
    required(:url) { filled? & str? & format?(HTTP_FORMAT) & feed_url? }
    required(:kind) { filled? & str? & included_in?(FeedKind.all) }
  end
end
