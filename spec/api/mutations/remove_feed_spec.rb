# frozen_string_literal: true

RSpec.describe Mutations::RemoveFeed do
  include TransactionalSpec

  let(:repository) { FeedRepository.new }

  let(:query) do
    <<-GRAPHQL
      mutation ($id: ID!) {
        removeFeed(id: $id)
      }
    GRAPHQL
  end

  context 'with valid data' do
    let!(:feed) { repository.create(title: 'Blog', url: 'https://blog.com/feed.xml') }

    it 'successfully remove feed record' do
      expect(repository.all.count).to eq 1

      result = Schema.execute(query, variables: { id: feed.id }).to_h

      expect(result['data']['removeFeed']).to be_truthy

      expect(repository.all.count).to eq 0
    end
  end

  context 'with invalid data' do
    it 'does not remove a feed which does not exist' do
      expect(repository.all.count).to eq 0

      result = Schema.execute(query, variables: { id: SecureRandom.uuid }).to_h

      expect(result['data']['removeFeed']).to be_falsy
    end
  end
end
