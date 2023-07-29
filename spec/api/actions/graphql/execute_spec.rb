# frozen_string_literal: true

RSpec.describe API::Actions::Graphql::Execute, :db, type: :action do
  let(:action) { described_class.new }
  let(:params) do
    { query: %({ feeds { title url } }) }
  end

  let!(:feed) do
    FeedTheHungry::Repositories::FeedRepository.new.create(title: 'My feed', url: 'https://myfeed.com/feed.xml')
  end

  it 'is successful' do
    response = action.call(params)

    expect(response.status).to eq 200

    result = JSON.parse(response.body.first)

    expect(result).to eq(
      'data' => {
        'feeds' => [
          {
            'title' => feed.title,
            'url' => feed.url
          }
        ]
      }
    )
  end
end
