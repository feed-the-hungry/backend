# frozen_string_literal: true

class UserRepository < Hanami::Repository
  include ExistHelper

  associations do
    has_many :feeds, through: :user_feeds
  end

  def email_exist?(email: nil)
    exist?(field: :email, value: email, collection: users)
  end

  def find_with_feeds(id)
    aggregate(:feeds)
      .where(id: id)
      .order(feeds[:created_at])
      .map_to(User).one
  end

  def add_feed(user, feed)
    assoc(:feeds, user).add(feed)
  end
end
