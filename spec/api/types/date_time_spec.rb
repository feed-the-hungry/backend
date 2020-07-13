# frozen_string_literal: true

RSpec.describe Types::DateTime do
  describe '.coerce_input' do
    it 'not passing a value' do
      expect(described_class.coerce_input(nil, nil)).to be_nil
    end

    it 'passing a blank string' do
      expect(described_class.coerce_input(' ', nil)).to be_nil
    end

    it 'passing an invalid string value to be coerced' do
      expect do
        described_class.coerce_input('2020-01', nil)
      end.to raise_error GraphQL::CoercionError
    end

    it 'passing a valid string value to be coerced' do
      value = '2020-01-01T03:00:00Z'

      expect(described_class.coerce_input(value, nil)).to eq Time.parse(value)
    end
  end

  describe '.coerce_result' do
    it 'not passing a value' do
      expect(described_class.coerce_result(nil, nil)).to be_nil
    end

    it 'passing an invalid value' do
      expect do
        described_class.coerce_result('Value', nil)
      end.to raise_error GraphQL::CoercionError

      expect do
        described_class.coerce_result('2020-01', nil)
      end.to raise_error GraphQL::CoercionError
    end

    it 'passing a DateTime value' do
      datetime = DateTime.parse('2020-01-01T03:00:00Z')

      expect(described_class.coerce_result(datetime, nil)).to(
        eq '2020-01-01T03:00:00Z'
      )
    end
  end
end
