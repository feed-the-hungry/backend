# frozen_string_literal: true

require 'hanami/interactor'

require_relative 'interactor_helpers'
require_relative 'add_feed_to_user'

class UpdateFeed
  include Hanami::Interactor
  include InteractorHelpers
  include AddFeedToUser

  expose :feed

  def initialize(repository: FeedRepository.new, user_repository: UserRepository.new)
    @repository = repository
    @user_repository = user_repository
  end

  def call(id, attributes)
    result = FeedTheHungry::Validators::FeedValidator.new(attributes).validate

    if result.success?
      @feed = update_or_return_feed(id, attributes)

      add_feed_to_user!(@feed, attributes[:user_id])
    else
      error_messages(result)
    end
  end

  private

  attr_reader :repository, :user_repository

  def update_or_return_feed(id, attributes)
    url = attributes[:url]

    if repository.url_exist?(url: url)
      repository.find_by_url(url)
    else
      repository.update(id, attributes)
    end
  end
end
