RSpec.describe Api::Controllers::Graphql::Execute, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    pending 'until define the first query type'

    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
