# frozen_string_literal: true

class UserRepository < Hanami::Repository
  associations do
    has_many :feeds, through: :user_feeds
  end

  def email_exist?(id: nil, email: nil)
    return false if email.nil? || email&.strip == ''

    if id.nil?
      users.exist?(email: email)
    else
      users
        .exclude(id: id)
        .exist?(email: email)
    end
  end

  def find_with_feeds(id)
    aggregate(:feeds)
      .where(id: id)
      .order(feeds[:created_at].asc)
      .map_to(User).one
  end

  def add_feed(user, feed)
    assoc(:feeds, user).add(feed)
  end
end
