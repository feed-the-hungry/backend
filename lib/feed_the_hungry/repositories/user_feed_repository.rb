# frozen_string_literal: true

class UserFeedRepository < Hanami::Repository
  associations do
    belongs_to :user
    belongs_to :feed
  end

  def feeds_from_user(user)
    user_feeds
      .where(user_id: user.id)
      .feeds
      .order(feeds[:created_at].qualified)
      .map
      .to_a
  end
end
