# frozen_string_literal: true

class EntryRepository < Hanami::Repository
  associations do
    belongs_to :feed
  end
end
