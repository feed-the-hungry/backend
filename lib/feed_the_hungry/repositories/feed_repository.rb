# frozen_string_literal: true

class FeedRepository < Hanami::Repository
  include ExistHelper

  associations do
    has_many :users, through: :user_feeds

    has_many :entries
  end

  def url_exist?(url: nil)
    exist?(field: :url, value: url, collection: feeds)
  end

  def find_by_url(url)
    feeds.where(url: url).first
  end
end
