# frozen_string_literal: true

class UserValidator
  include Hanami::Validations

  messages :i18n

  predicate :email? do |current|
    current =~ FeedTheHungry::EMAIL_REGEX
  end

  validations do
    required(:name) { filled? & str? }
    required(:email) { filled? & str? & email? }
  end
end
