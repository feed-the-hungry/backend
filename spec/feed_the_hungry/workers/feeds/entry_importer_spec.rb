# frozen_string_literal: true

RSpec.describe FeedTheHungry::Workers::Feeds::EntryImporter do
  describe '#perform' do
    it do
      entries_import = double

      expect(entries_import).to receive(:call)

      allow(FeedTheHungry::Interactors::Entries::Import).to receive(:new).and_return(entries_import)

      described_class.new.perform
    end
  end
end
