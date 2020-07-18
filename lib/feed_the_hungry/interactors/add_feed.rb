# frozen_string_literal: true

require 'hanami/interactor'

class AddFeed
  include Hanami::Interactor

  expose :feed

  def initialize(repository: FeedRepository.new)
    @repository = repository
  end

  def call(attributes)
    result = FeedValidator.new(attributes).validate

    if result.success?
      @feed = repository.create(attributes)
    else
      messages = result.messages
      output = result.output

      messages.each do |attribute, message|
        error({ attribute => { value: output[attribute], message: message } })
      end
    end
  end

  private

  attr_reader :repository
end
