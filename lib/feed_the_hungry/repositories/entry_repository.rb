# frozen_string_literal: true

require_relative '../repository'

module FeedTheHungry
  module Repositories
    class EntryRepository < Repository[:entries]
      commands :create,
               use: :timestamps,
               plugins_options: { timestamps: { timestamps: %i[created_at updated_at] } }
    end
  end
end
