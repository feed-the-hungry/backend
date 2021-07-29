# frozen_string_literal: true

RSpec.describe Mutations::AddFeed do
  include TransactionalSpec

  let(:repository) { FeedRepository.new }

  let(:user_repository) { UserRepository.new }

  let!(:user) { user_repository.create(name: 'Jack', email: 'jack@email.com') }

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
    context 'with a new feed' do
      let(:input) do
        {
          title: 'Bruno Arueira',
          kind: FeedKind::TEXT.upcase,
          url: 'https://brunoarueira.com/feed.xml',
          userId: user.id
        }
      end

      it 'successfully create' do
        expect(repository.all.count).to eq 0

        Schema.execute(query, variables: variables)

        expect(repository.all.count).to eq 1

        last_user = user_repository.find_with_feeds(user.id)

        expect(last_user.feeds.length).to eq 1
      end
    end

    context 'with an existent feed' do
      let!(:another_user) { user_repository.create(name: 'Bob', email: 'bob@email.com') }
      let!(:another_feed) do
        repository.create(input.merge(id: another_user.id, kind: FeedKind::TEXT))
      end

      let(:input) do
        {
          title: 'Bruno Arueira',
          kind: FeedKind::TEXT.upcase,
          url: 'https://brunoarueira.com/feed.xml',
          userId: user.id
        }
      end

      it 'successfully add to user' do
        expect(repository.all.count).to eq 1

        Schema.execute(query, variables: variables)

        expect(repository.all.count).to eq 1

        last_user = user_repository.find_with_feeds(user.id)

        expect(last_user.feeds.length).to eq 1
      end
    end
  end

  context 'invalid' do
    context 'url' do
      let(:input) do
        {
          title: 'My feed',
          kind: FeedKind::TEXT.upcase,
          url: 'feed',
          userId: user.id
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
          url: 'https://brunoarueira.com',
          userId: user.id
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
