# frozen_string_literal: true

RSpec.describe Mutations::AddFeed do
  include TransactionalSpec

  let(:repository) { FeedRepository.new }

  let(:query) do
    <<-GRAPHQL
      mutation ($input: FeedInput!) {
        addFeed(input: $input) {
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
      input: input
    }
  end

  context 'valid' do
    let(:input) do
      {
        title: 'Bruno Arueira',
        kind: FeedKind::TEXT.upcase,
        url: 'https://brunoarueira.com/feed.xml'
      }
    end

    it 'successfully create a new feed' do
      expect(repository.all.count).to eq 0

      Schema.execute(query, variables: variables)

      expect(repository.all.count).to eq 1
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

      it 'does not create a new feed and report errors' do
        expect(repository.all.count).to eq 0

        result = Schema.execute(query, variables: variables).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['url'],
            'explanation' => '"feed" is not a valid URL',
            'message' => '"feed" is not a valid URL'
          }]
        )

        expect(repository.all.count).to eq 0
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

      it 'does not create a new feed and report errors' do
        expect(repository.all.count).to eq 0

        result = Schema.execute(query, variables: variables).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['url'],
            'explanation' => '"https://brunoarueira.com" must be a feed url',
            'message' => '"https://brunoarueira.com" must be a feed url'
          }]
        )

        expect(repository.all.count).to eq 0
      end
    end
  end
end
