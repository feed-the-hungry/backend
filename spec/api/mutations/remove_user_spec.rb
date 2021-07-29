# frozen_string_literal: true

RSpec.describe Mutations::RemoveUser do
  include TransactionalSpec

  let(:repository) { UserRepository.new }

  let(:query) do
    <<-GRAPHQL
      mutation ($id: ID!) {
        removeUser(id: $id)
      }
    GRAPHQL
  end

  context 'valid' do
    let!(:user) { repository.create(name: 'Jack', email: 'jack@email.com') }

    let(:variables) do
      {
        id: user.id
      }
    end

    it 'successfully remove user record' do
      expect(repository.all.count).to eq 1

      result = Schema.execute(query, variables: variables).to_h

      expect(result['data']['removeUser']).to be_truthy

      expect(repository.all.count).to eq 0
    end
  end

  context 'invalid' do
    let(:variables) do
      {
        id: SecureRandom.uuid
      }
    end

    it 'does not remove a user which does not exist' do
      expect(repository.all.count).to eq 0

      result = Schema.execute(query, variables: variables).to_h

      expect(result['data']['removeUser']).to be_falsy
    end
  end
end
