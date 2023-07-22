# frozen_string_literal: true

RSpec.describe Mutations::UpdateUser do
  include TransactionalSpec

  let(:repository) { FeedTheHungry::Repositories::UserRepository.new }

  let!(:user) { repository.create(name: 'Bob', email: 'bob@email.com') }

  let(:query) do
    <<-GRAPHQL
      mutation ($id: ID!, $input: UserInput!) {
        updateUser(id: $id, input: $input) {
          user {
            id
            name
            email
          }
        }
      }
    GRAPHQL
  end

  let(:variables) do
    {
      id: user.id,
      input:
    }
  end

  context 'with valid data' do
    let(:input) do
      {
        name: 'Jack',
        email: 'jack@email.com'
      }
    end

    it 'successfully update a user' do
      expect(repository.all.count).to eq 1

      result = Schema.execute(query, variables:).to_h

      expect(result['data']['updateUser']).to(
        eq(
          'user' => {
            'id' => user.id,
            'name' => 'Jack',
            'email' => 'jack@email.com'
          }
        )
      )

      expect(repository.all.count).to eq 1
    end
  end

  context 'with invalid data' do
    context 'when email already exists' do
      let(:input) do
        {
          name: 'Jack',
          email: 'jack@email.com'
        }
      end

      before do
        repository.create(input)
      end

      it 'does not update a user and report errors' do
        expect(repository.all.count).to eq 2

        result = Schema.execute(query, variables:).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['email'],
            'explanation' => '"jack@email.com" is in use',
            'message' => '"jack@email.com" is in use'
          }]
        )

        expect(repository.all.count).to eq 2
      end
    end

    context 'when invalid email' do
      let(:input) do
        {
          name: 'Jack',
          email: 'jack'
        }
      end

      it 'does not update a user and report errors' do
        expect(repository.all.count).to eq 1

        result = Schema.execute(query, variables:).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['email'],
            'explanation' => '"jack" is not a valid email',
            'message' => '"jack" is not a valid email'
          }]
        )

        expect(repository.all.count).to eq 1
      end
    end

    context 'when the data is invalid' do
      let(:input) do
        {
          name: '',
          email: 'jack@email.com'
        }
      end

      it 'does not update a user and report errors' do
        expect(repository.all.count).to eq 1

        result = Schema.execute(query, variables:).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['name'],
            'explanation' => '"" can not be blank',
            'message' => '"" can not be blank'
          }]
        )

        expect(repository.all.count).to eq 1
      end
    end
  end
end
