# frozen_string_literal: true

require_relative 'base_scalar'

module Types
  class Url < Types::BaseScalar
    description 'A valid URL, transported as a string'

    def self.coerce_input(value, _ctx)
      url = URI.parse(value)

      if url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
        value.to_s
      else
        raise_coercion_error("#{value.inspect} is not a valid URL")
      end
    end

    def self.coerce_result(value, _ctx)
      url = URI.parse(value)

      if url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
        value.to_s
      else
        raise_coercion_error("#{value.inspect} is not a valid URL")
      end
    end
  end
end
