# frozen_string_literal: true

require_relative 'repository'

module FeedTheHungry
  module Repositories
    class FeedRepository < FeedTheHungry::Repository[:feeds]
      include ExistHelper

      commands :create,
               use: :timestamps,
               plugin_options: { timestamps: { timestamps: %i[created_at updated_at] } }

      def url_exist?(url: nil)
        exist?(field: :url, value: url, collection: feeds)
      end

      def find_by_url(url)
        feeds.where(url:).first
      end
    end
  end
end
