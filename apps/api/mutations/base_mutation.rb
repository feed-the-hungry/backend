# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    INVALID_RESOURCE = 'INVALID_RESOURCE'

    def raise_invalid_resource(resource_name, result)
      raise GraphQL::ExecutionError.new(
        I18n.t('errors.messages.invalid_resource', resource_name: resource_name),
        extensions: {
          code: INVALID_RESOURCE,
          problems: format_errors(result)
        }.transform_keys!(&:to_s)
      )
    end

    private

    def format_errors(result)
      messages = result.messages
      output = result.output

      messages.map do |key, value|
        default_format(key, output[key], value.map(&:strip).join(', '))
      end
    end

    def default_format(attribute, value, message)
      {
        path: [attribute.to_s],
        explanation: "\"#{value}\" #{message}",
        message: "\"#{value}\" #{message}"
      }.transform_keys!(&:to_s)
    end
  end
end
