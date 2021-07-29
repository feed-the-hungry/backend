# frozen_string_literal: true

class UserFeedRepository < Hanami::Repository
  associations do
    belongs_to :user
    belongs_to :feed
  end
end
