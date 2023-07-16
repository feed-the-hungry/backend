# frozen_string_literal: true

require_relative '../entities'

module FeedTheHungry
  module Repositories
    class Repository < ROM::Repository::Root
      struct_namespace FeedTheHungry::Entities

      auto_struct true

      def self.[](relation)
        Class.new(self) { root(relation) }
      end

      def self.new
        super(Persistence.db)
      end

      def all
        root.to_a
      end

      def first
        root.first
      end

      def last
        root.last
      end

      def create(attrs)
        root.changeset(:create, attrs).map(:add_timestamps).commit
      end

      def update(id, attrs)
        root.by_pk(id).changeset(:update, attrs).map(:touch).commit
      end

      def delete(id)
        root.by_pk(id).command(:delete, result: :one).call
      end

      def find(id)
        root.by_pk(id).first
      end

      def clear
        root.delete
      end

      def entity_class
        root.mapper.model
      end
    end
  end
end
