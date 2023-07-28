# frozen_string_literal: true

require 'graphql'

module API
  module Mutations
    class BaseMutation < GraphQL::Schema::Mutation
      INVALID_RESOURCE = 'INVALID_RESOURCE'

      def raise_invalid_resource(resource_name, errors)
        raise GraphQL::ExecutionError.new(
          I18n.t(
            'errors.messages.invalid_resource',
            resource_name:
          ),
          extensions: {
            code: INVALID_RESOURCE,
            problems: format_errors(errors)
          }.transform_keys!(&:to_s)
        )
      end

      def self.basic_update_arguments(return_field_name:, return_type:, input_type:)
        argument :id, ID, required: true
        argument :input, input_type, required: true

        field return_field_name, return_type, null: true
      end

      def self.basic_add_arguments(return_field_name:, return_type:, input_type:)
        argument :input, input_type, required: true

        field return_field_name, return_type, null: true
      end

      private

      def format_errors(errors)
        errors.map do |error|
          default_format(error.keys.first, error.values.first)
        end
      end

      def default_format(attribute, value)
        {
          path: [attribute.to_s],
          explanation: "\"#{value[:value]}\" #{value[:message].join(', ')}",
          message: "\"#{value[:value]}\" #{value[:message].join(', ')}"
        }.transform_keys!(&:to_s)
      end
    end
  end
end
