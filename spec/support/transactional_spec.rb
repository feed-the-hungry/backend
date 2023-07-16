# frozen_string_literal: true

module TransactionalSpec
  def self.included(_module)
    RSpec.configure do |config|
      config.around do |example|
        FeedTheHungry::Persistence.relations[:user_feeds].transaction do |t|
          example.run

          t.rollback!
        end
      end
    end
  end
end
