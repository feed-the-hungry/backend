# frozen_string_literal: true

require 'hanami/interactor'

require_relative 'interactor_helpers'

class AddUser
  include Hanami::Interactor
  include InteractorHelpers

  expose :user

  def initialize(repository: FeedTheHungry::Repositories::UserRepository.new)
    @repository = repository
  end

  def call(attributes)
    result = UserValidator.new(attributes).validate

    email_exist = repository.email_exist?(email: attributes[:email])

    if result.success? && !email_exist
      @user = repository.create(attributes)
    else
      error_messages(result)

      unique_error(:email, attributes[:email]) if email_exist
    end
  end

  private

  attr_reader :repository
end
