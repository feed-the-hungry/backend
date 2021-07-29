# frozen_string_literal: true

module AddFeedToUser
  def add_feed_to_user!(feed, user_id)
    user = user_repository.find(user_id)

    user_repository.add_feed(user, feed)
  end
end
