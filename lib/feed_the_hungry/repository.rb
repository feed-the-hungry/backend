# frozen_string_literal: true

require 'rom-repository'

module FeedTheHungry
  class Repository < ROM::Repository::Root
    include Deps[container: 'persistence.rom']

    auto_struct true

    struct_namespace FeedTheHungry::Entities

    def exist?(field:, value: nil)
      return false if value.nil? || value&.strip == ''

      root.exist?(field => value)
    end

    def all
      root.order(:created_at)
    end

    def last
      all.last
    end

    def find(id)
      root.by_pk(id).one
    end

    def delete(id)
      root.by_pk(id).command(:delete, result: :one).call
    end
  end
end
