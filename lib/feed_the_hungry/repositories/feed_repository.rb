# frozen_string_literal: true

require_relative 'repository'

module FeedTheHungry
  module Repositories
    class FeedRepository < Repository[:feeds]
      include ExistHelper

      def url_exist?(url: nil)
        exist?(field: :url, value: url, collection: feeds)
      end

      def find_by_url(url)
        feeds.where(url: url).first
      end
    end
  end
end
