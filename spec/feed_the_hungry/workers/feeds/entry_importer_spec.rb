# frozen_string_literal: true

RSpec.describe FeedTheHungry::Workers::Feeds::EntryImporter do
  describe '#perform' do
    it do
      entries_import = spy

      allow(FeedTheHungry::Interactors::Entries::Import).to receive(:new).and_return(entries_import)

      described_class.new.perform

      expect(entries_import).to have_received(:call)
    end
  end
end
