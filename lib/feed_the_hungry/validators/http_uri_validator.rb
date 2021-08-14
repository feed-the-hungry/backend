require 'uri'

module FeedTheHungry
  module Validators
    module HttpUriValidator
      HTTP_FORMAT = URI::DEFAULT_PARSER.make_regexp(%w[http https])

      def self.valid?(value)
        value.match?(HTTP_FORMAT)
      end
    end
  end
end
