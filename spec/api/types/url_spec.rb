# frozen_string_literal: true

RSpec.describe API::Types::Url do
  describe '.coerce_input' do
    it 'passing an invalid string value to be coerced' do
      expect do
        described_class.coerce_input('2020', nil)
      end.to raise_error GraphQL::CoercionError

      expect do
        described_class.coerce_input('', nil)
      end.to raise_error GraphQL::CoercionError
    end

    it 'passing a valid string value to be coerced' do
      value = 'https://myfeed.com/feed.xml'

      expect(described_class.coerce_input(value, nil)).to eq value
    end
  end

  describe '.coerce_result' do
    it 'passing an invalid value' do
      expect do
        described_class.coerce_result('Value', nil)
      end.to raise_error GraphQL::CoercionError

      expect do
        described_class.coerce_result('2020-01', nil)
      end.to raise_error GraphQL::CoercionError
    end

    it 'passing an url value' do
      value = 'https://myfeed.com/feed.xml'

      expect(described_class.coerce_result(value, nil)).to eq value
    end
  end
end
