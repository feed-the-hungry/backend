# frozen_string_literal: true

RSpec.describe Mutations::AddUser do
  include TransactionalSpec

  let(:repository) { UserRepository.new }

  let(:query) do
    <<-GRAPHQL
      mutation ($input: UserInput!) {
        addUser(input: $input) {
          user {
            name
            email
          }
        }
      }
    GRAPHQL
  end

  let(:variables) do
    {
      input: input
    }
  end

  context 'valid' do
    let(:input) do
      {
        name: 'Jack',
        email: 'jack@email.com'
      }
    end

    it 'successfully create a new user' do
      expect(repository.all.count).to eq 0

      Schema.execute(query, variables: variables)

      expect(repository.all.count).to eq 1
    end
  end

  context 'invalid' do
    context 'email already exists' do
      let!(:user) { repository.create(input) }

      let(:input) do
        {
          name: 'Jack',
          email: 'jack@email.com'
        }
      end

      it 'does not create a new user and report errors' do
        expect(repository.all.count).to eq 1

        result = Schema.execute(query, variables: variables).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['email'],
            'explanation' => '"jack@email.com" is in use',
            'message' => '"jack@email.com" is in use'
          }]
        )

        expect(repository.all.count).to eq 1
      end
    end

    context 'invalid email' do
      let(:input) do
        {
          name: 'Jack',
          email: 'jack'
        }
      end

      it 'does not create a new user and report errors' do
        expect(repository.all.count).to eq 0

        result = Schema.execute(query, variables: variables).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['email'],
            'explanation' => '"jack" is not a valid email',
            'message' => '"jack" is not a valid email'
          }]
        )

        expect(repository.all.count).to eq 0
      end
    end

    context 'invalid data' do
      let(:input) do
        {
          name: '',
          email: 'jack@email.com'
        }
      end

      it 'does not create a new user and report errors' do
        expect(repository.all.count).to eq 0

        result = Schema.execute(query, variables: variables).to_h

        expect(result['errors'][0]['extensions']['problems']).to eq(
          [{
            'path' => ['name'],
            'explanation' => '"" can not be blank',
            'message' => '"" can not be blank'
          }]
        )

        expect(repository.all.count).to eq 0
      end
    end
  end
end
