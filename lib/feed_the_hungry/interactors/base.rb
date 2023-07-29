# frozen_string_literal: true

module FeedTheHungry
  module Interactors
    module Base
      def self.included(base)
        base.extend(ClassMethods)
      end

      attr_reader :errors

      def error_messages(result)
        errors = result.errors
        output = result

        errors.each do |error|
          attribute = error.path.first

          error({ attribute => { value: output[attribute], message: [error.text] } })
        end
      end

      def unique_error(attribute, value)
        error(
          {
            attribute => { value:, message: [I18n.t('errors.messages.unique')] }
          }
        )
      end

      def successful?
        @errors.nil? ||
          @errors.empty?
      end

      module ClassMethods
        def expose(attribute)
          attr_reader attribute.to_sym
        end
      end

      private

      attr_reader :success

      def error(item)
        @errors ||= []
        @errors << item
      end
    end
  end
end
