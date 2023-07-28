# frozen_string_literal: true

RSpec.describe API::Types::Email do
  describe '.coerce_input' do
    it 'passing an invalid string value to be coerced' do
      expect do
        described_class.coerce_input('email', nil)
      end.to raise_error GraphQL::CoercionError

      expect do
        described_class.coerce_input('', nil)
      end.to raise_error GraphQL::CoercionError
    end

    it 'passing a valid string value to be coerced' do
      value = 'jack@email.com'

      expect(described_class.coerce_input(value, nil)).to eq value
    end
  end

  describe '.coerce_result' do
    it 'passing an invalid value' do
      expect do
        described_class.coerce_result('email', nil)
      end.to raise_error GraphQL::CoercionError

      expect do
        described_class.coerce_result('email.com', nil)
      end.to raise_error GraphQL::CoercionError
    end

    it 'passing an email value' do
      value = 'jack@email.com'

      expect(described_class.coerce_result(value, nil)).to eq value
    end
  end
end
