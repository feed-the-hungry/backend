# frozen_string_literal: true

class UserRepository < Hanami::Repository
  include ExistHelper

  associations do
    has_many :user_feeds
    has_many :feeds, through: :user_feeds
  end

  def email_exist?(email: nil)
    exist?(field: :email, value: email, collection: users)
  end

  def add_feed(user, feed)
    assoc(:feeds, user).add(feed)
  end
end
