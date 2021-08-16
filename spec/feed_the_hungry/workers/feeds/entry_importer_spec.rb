# frozen_string_literal: true

RSpec.describe FeedTheHungry::Workers::Feeds::EntryImporter do
  describe '#perform' do
    it do
      import_interactor = instance_double('FeedTheHungry::Interactors::Entries::Import')

      allow_any_instance_of(import_interactor).to receive(:call)

      described_class.new.perform
    end
  end
end
