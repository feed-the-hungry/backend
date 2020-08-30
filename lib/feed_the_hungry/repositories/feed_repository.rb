# frozen_string_literal: true

class FeedRepository < Hanami::Repository
  include ExistHelper

  associations do
    has_many :users, through: :user_feeds
  end

  def url_exist?(id: nil, url: nil)
    exist?(id: id, field: :url, value: url, collection: feeds)
  end

  def find_by_url(url)
    feeds.where(url: url).first
  end
end
