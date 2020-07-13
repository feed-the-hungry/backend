# frozen_string_literal: true

require_relative 'base_scalar'

module Types
  class DateTime < Types::BaseScalar
    description 'A valid DateTime, transported as a string'

    def self.coerce_input(value, _ctx)
      return if value.nil? || value&.strip == ''

      return value if value.is_a?(DateTime)

      Time.parse(value)
    rescue ArgumentError
      raise_coercion_error("#{value.inspect} is not a valid DateTime")
    end

    def self.coerce_result(value, _ctx)
      return if value.nil?

      if value.respond_to?(:to_time)
        value.to_time.utc.iso8601
      else
        raise_coercion_error("#{value.inspect} is not a valid DateTime")
      end
    end
  end
end
