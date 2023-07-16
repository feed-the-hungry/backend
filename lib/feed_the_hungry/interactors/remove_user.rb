# frozen_string_literal: true

require 'hanami/interactor'

class RemoveUser
  include Hanami::Interactor

  expose :user

  def initialize(repository: FeedTheHungry::Repositories::UserRepository.new)
    @repository = repository
  end

  def call(id)
    @user = repository.delete(id)
  end

  private

  attr_reader :repository
end
