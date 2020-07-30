# frozen_string_literal: true

RSpec.describe Types::User do
  let!(:user) { UserRepository.new.create(name: 'Jack', email: 'jack@email.com') }

  let(:feed_repository) { FeedRepository.new }
  let(:feed_one) do
    feed_repository.create(
      title: 'Blog 1',
      url: 'https://blog.com/feed.xml',
      kind: FeedKind::TEXT
    )
  end
  let(:feed_two) do
    feed_repository.create(
      title: 'Blog 2',
      url: 'https://blogtwo.com/feed.xml',
      kind: FeedKind::TEXT
    )
  end
  let(:user_feed_repository) { UserFeedRepository.new }
  let!(:user_feed_one) { user_feed_repository.create(user_id: user.id, feed_id: feed_one.id) }
  let!(:user_feed_two) do
    user_feed_repository.create(
      user_id: user.id,
      feed_id: feed_two.id,
      created_at: DateTime.now + 120
    )
  end

  let(:query) do
    <<-GRAPHQL
      query ($id: ID!) {
        user(id: $id) {
          name
          email
          feeds {
            edges {
              node {
                title
                url
                kind
              }
            }
          }
        }
      }
    GRAPHQL
  end

  let(:variables) do
    {
      id: user.id
    }
  end

  it 'return a user with their feeds' do
    result = Schema.execute(query, variables: variables).to_h

    expect(result['data']).to eq(
      'user' => {
        'email' => 'jack@email.com',
        'name' => 'Jack',
        'feeds' => {
          'edges' => [
            {
              'node' => {
                'kind' => FeedKind::TEXT.upcase,
                'title' => 'Blog 1',
                'url' => 'https://blog.com/feed.xml'
              }
            },
            {
              'node' => {
                'kind' => FeedKind::TEXT.upcase,
                'title' => 'Blog 2',
                'url' => 'https://blogtwo.com/feed.xml'
              }
            }
          ]
        }
      }
    )
  end
end
