# frozen_string_literal: true

require 'rom-repository'

module FeedTheHungry
  class Repository < ROM::Repository::Root
    include Deps[container: 'persistence.rom']

    auto_struct true

    struct_namespace FeedTheHungry::Entities
  end
end
