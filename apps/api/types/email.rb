# frozen_string_literal: true

require_relative 'base_scalar'

module Types
  class Email < Types::BaseScalar
    description 'A valid email'

    def self.coerce_input(value, _ctx)
      if FeedTheHungry::EMAIL_REGEX.match?(value)
        value.to_s
      else
        raise_coercion_error("#{value.inspect} is not a valid email")
      end
    end

    def self.coerce_result(value, _ctx)
      if FeedTheHungry::EMAIL_REGEX.match?(value)
        value.to_s
      else
        raise_coercion_error("#{value.inspect} is not a valid email")
      end
    end
  end
end
