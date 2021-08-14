# frozen_string_literal: true

require 'hanami/interactor'

require_relative 'interactor_helpers'

class UpdateUser
  include Hanami::Interactor
  include InteractorHelpers

  expose :user

  def initialize(repository: UserRepository.new)
    @repository = repository
  end

  def call(id, attributes)
    result = UserValidator.new(attributes).validate

    email_exist = repository.email_exist?(email: attributes[:email])

    if result.success? && !email_exist
      @user = repository.update(id, attributes)
    else
      error_messages(result)

      unique_error(:email, attributes[:email]) if email_exist
    end
  end

  private

  attr_reader :repository
end
