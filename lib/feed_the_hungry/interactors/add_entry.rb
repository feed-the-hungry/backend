# frozen_string_literal: true

require 'hanami/interactor'

require_relative 'interactor_helpers'

class AddEntry
  include Hanami::Interactor
  include InteractorHelpers

  expose :entry

  def initialize(repository: FeedTheHungry::Repositories::EntryRepository.new)
    @repository = repository
  end

  def call(attributes)
    result = FeedTheHungry::Validators::EntryValidator.new(attributes).validate

    if result.success?
      @entry = repository.create(attributes)
    else
      error_messages(result)

      fail!
    end
  end

  private

  attr_reader :repository
end
