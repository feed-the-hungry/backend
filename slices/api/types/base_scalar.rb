# frozen_string_literal: true

module Types
  class BaseScalar < GraphQL::Schema::Scalar
    class << self
      protected

      def raise_coercion_error(message)
        raise GraphQL::CoercionError, message
      end
    end
  end
end
