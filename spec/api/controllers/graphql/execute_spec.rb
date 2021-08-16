# frozen_string_literal: true

RSpec.describe Api::Controllers::Graphql::Execute, type: :action do
  include TransactionalSpec

  let(:action) { described_class.new }
  let(:params) do
    { query: %({ feeds { title url } }) }
  end

  let!(:feed) do
    FeedRepository.new.create(title: 'My feed', url: 'https://myfeed.com/feed.xml')
  end

  it 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq 200

    result = JSON.parse(response[2].first)

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
