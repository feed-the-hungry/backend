# frozen_string_literal: true

RSpec.describe Mutations::UpdateFeed do
  include TransactionalSpec

  let(:repository) { FeedRepository.new }

  let!(:feed) do
    repository.create(title: 'Blog', kind: FeedKind::TEXT, url: 'https://blog.com/feed.xml')
  end

  let(:query) do
    <<-GRAPHQL
      mutation ($id: ID!, $input: FeedInput!) {
        updateFeed(id: $id, input: $input) {
          feed {
            title
            kind
            url
          }
        }
      }
    GRAPHQL
  end

  let(:variables) do
    {
      id: feed.id,
      input: input
    }
  end

  context 'valid' do
    let(:input) do
      {
        title: 'My feed',
        kind: FeedKind::TEXT.upcase,
        url: 'https://brunoarueira.com/feed.xml'
      }
    end

    it 'successfully update feed record' do
      expect(repository.all.count).to eq 1

      Schema.execute(query, variables: variables)

      expect(repository.all.count).to eq 1

      last_feed = repository.last

      expect(last_feed.title).to eq 'My feed'
      expect(last_feed.url).to eq 'https://brunoarueira.com/feed.xml'
    end
  end

  context 'invalid' do
    context 'url' do
      let(:input) do
        {
          title: 'My feed',
          kind: FeedKind::TEXT.upcase,
          url: 'feed'
        }
      end

      it 'does not update a feed with invalid input and report errors' do
        expect(repository.all.count).to eq 1

        result = Schema.execute(query, variables: variables).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['url'],
            'explanation' => '"feed" is not a valid URL',
            'message' => '"feed" is not a valid URL'
          }]
        )

        expect(repository.all.count).to eq 1

        last_feed = repository.last

        expect(last_feed.title).to eq 'Blog'
        expect(last_feed.url).to eq 'https://blog.com/feed.xml'
      end
    end

    context 'feed' do
      let(:input) do
        {
          title: 'My feed',
          kind: FeedKind::TEXT.upcase,
          url: 'https://brunoarueira.com'
        }
      end

      it 'does not update a feed and report errors' do
        expect(repository.all.count).to eq 1

        result = Schema.execute(query, variables: variables).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['url'],
            'explanation' => '"https://brunoarueira.com" must be a feed url',
            'message' => '"https://brunoarueira.com" must be a feed url'
          }]
        )

        expect(repository.all.count).to eq 1

        last_feed = repository.last

        expect(last_feed.title).to eq 'Blog'
        expect(last_feed.url).to eq 'https://blog.com/feed.xml'
      end
    end
  end
end
