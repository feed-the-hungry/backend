# frozen_string_literal: true

class FeedRepository < Hanami::Repository
  associations do
    has_many :users, through: :user_feeds
  end

  def url_exist?(id: nil, url: nil)
    return false if url.nil? || url&.strip == ''

    if id.nil?
      feeds.exist?(url: url)
    else
      feeds.exclude(id: id).exist?(url: url)
    end
  end

  def find_by_url(url)
    feeds.where(url: url).first
  end
end
