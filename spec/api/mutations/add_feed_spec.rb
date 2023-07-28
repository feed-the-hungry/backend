# frozen_string_literal: true

RSpec.describe API::Mutations::AddFeed, :db do
  let(:repository) { FeedTheHungry::Repositories::FeedRepository.new }

  let(:user_repository) { FeedTheHungry::Repositories::UserRepository.new }

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

  context 'with valid data' do
    context 'when is a new feed' do
      let(:input) do
        {
          title: 'Bruno Arueira',
          kind: FeedTheHungry::Enumerations::FeedKind::TEXT.upcase,
          url: 'https://brunoarueira.com/feed.xml',
          userId: user.id
        }
      end

      it 'successfully create' do
        expect(repository.all.count).to eq 0

        API::Schema.execute(query, variables: { input: })

        expect(repository.all.count).to eq 1

        feeds = FeedTheHungry::Repositories::UserFeedRepository.new.feeds_from_user(user)

        expect(feeds.length).to eq 1
      end
    end

    context 'when an existent feed is persisted' do
      let(:input) do
        {
          title: 'Bruno Arueira',
          kind: FeedTheHungry::Enumerations::FeedKind::TEXT.upcase,
          url: 'https://brunoarueira.com/feed.xml',
          userId: user.id
        }
      end

      it 'successfully add to user' do
        another_user = user_repository.create(name: 'Bob', email: 'bob@email.com')
        repository.create(input.merge(id: another_user.id, kind: FeedTheHungry::Enumerations::FeedKind::TEXT))

        expect(repository.all.count).to eq 1

        API::Schema.execute(query, variables: { input: })

        expect(repository.all.count).to eq 1

        feeds = FeedTheHungry::Repositories::UserFeedRepository.new.feeds_from_user(user)

        expect(feeds.length).to eq 1
      end
    end
  end

  context 'with invalid data' do
    context 'when url is invalid' do
      let(:input) do
        {
          title: 'My feed',
          kind: FeedTheHungry::Enumerations::FeedKind::TEXT.upcase,
          url: 'feed',
          userId: user.id
        }
      end

      it 'does not create a new feed and report errors' do
        expect(repository.all.count).to eq 0

        result = API::Schema.execute(query, variables: { input: }).to_h

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

    context 'when a url is not a feed', skip: 'feed validator based on w3c is not working' do
      let(:input) do
        {
          title: 'My feed',
          kind: FeedTheHungry::Enumerations::FeedKind::TEXT.upcase,
          url: 'https://brunoarueira.com',
          userId: user.id
        }
      end

      it 'does not create a new feed and report errors' do
        expect(repository.all.count).to eq 0

        result = API::Schema.execute(query, variables: { input: }).to_h

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
