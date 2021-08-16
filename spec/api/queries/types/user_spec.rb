# frozen_string_literal: true

RSpec.describe Types::User do
  let!(:user) { UserRepository.new.create(name: 'Jack', email: 'jack@email.com') }

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

  before do
    feed_repository = FeedRepository.new
    user_feed_repository = UserFeedRepository.new

    feed_one =
      feed_repository.create(
        title: 'Blog 1',
        url: 'https://blog.com/feed.xml',
        kind: FeedKind::TEXT
      )
    feed_two =
      feed_repository.create(
        title: 'Blog 2',
        url: 'https://blogtwo.com/feed.xml',
        kind: FeedKind::TEXT
      )

    user_feed_repository.create(user_id: user.id, feed_id: feed_one.id)
    user_feed_repository.create(
      user_id: user.id,
      feed_id: feed_two.id
    )
  end

  it 'return a user with their feeds' do
    result = Schema.execute(query, variables: variables).to_h

    expect(result['data']).to include(
      'user' => {
        'email' => 'jack@email.com',
        'name' => 'Jack',
        'feeds' => hash_including({
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
                                  })
      }
    )
  end
end
