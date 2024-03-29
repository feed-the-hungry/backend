# frozen_string_literal: true

RSpec.describe FeedTheHungry::Interactors::Entries::Import, :db do
  let(:entry_repository) { FeedTheHungry::Repositories::EntryRepository.new }

  let!(:feed) do
    FeedTheHungry::Repositories::FeedRepository.new.create(
      title: 'Blog',
      kind: FeedTheHungry::Enumerations::FeedKind::TEXT,
      url: 'https://brunoarueira.com/feed.xml'
    )
  end

  describe '#call' do
    context 'with valid entries' do
      it 'fetches them from a rss feed and save on the database' do
        expect(entry_repository.all.count).to eq 0

        subject.call

        expect(entry_repository.all.count).to eq 6
      end
    end

    context 'with invalid entries' do
      it 'fetches them from a rss feed and does not save on the database' do
        entries = [{ feed_id: feed.id, guid: 'foo' }]

        allow(FeedTheHungry::Interactors::Entries::Parser).to receive(:call).and_return(entries)

        subject.call

        expect(entry_repository.all.count).to eq 0
      end
    end
  end
end
