# frozen_string_literal: true

module Test
  module DB
    module Helpers
      module_function

      def relations
        rom.relations
      end

      def rom
        Hanami.application['persistence.rom']
      end

      def db
        Hanami.application['persistence.db']
      end
    end

    class FactoryHelper < Module
      attr_reader :type

      def initialize(type = nil)
        super

        @type = type

        factory = entity_namespace ? Factory.struct_namespace(entity_namespace) : Factory

        define_method(:factory) do
          factory
        end
      end

      def entity_namespace
        @entity_namespace ||=
          case type
          when :main
            Api::Entities
          else
            FeedTheHungry::Entities
          end
      end
    end
  end
end
