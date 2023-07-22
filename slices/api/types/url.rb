# frozen_string_literal: true

require_relative 'base_scalar'

module Types
  class Url < Types::BaseScalar
    description 'A valid URL, transported as a string'

    class << self
      def coerce_input(value, _ctx)
        coerce(value)
      end

      def coerce_result(value, _ctx)
        coerce(value)
      end

      private

      def coerce(value)
        url = URI.parse(value)

        if url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
          value.to_s
        else
          raise_coercion_error("#{value.inspect} is not a valid URL")
        end
      end
    end
  end
end
