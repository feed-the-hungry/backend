# frozen_string_literal: true

RSpec.describe API::Mutations::AddUser, :db do
  let(:repository) { FeedTheHungry::Repositories::UserRepository.new }

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

    it 'successfully create a new user' do
      expect(repository.all.count).to eq 0

      API::Schema.execute(query, variables:)

      expect(repository.all.count).to eq 1
    end
  end

  context 'with invalid data' do
    context 'when email already exists' do
      let!(:user) { repository.create(input) }

      let(:input) do
        {
          name: 'Jack',
          email: 'jack@email.com'
        }
      end

      it 'does not create a new user and report errors' do
        expect(repository.all.count).to eq 1

        result = API::Schema.execute(query, variables:).to_h

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

    context 'when email is invalid' do
      let(:input) do
        {
          name: 'Jack',
          email: 'jack'
        }
      end

      it 'does not create a new user and report errors' do
        expect(repository.all.count).to eq 0

        result = API::Schema.execute(query, variables:).to_h

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

    context 'without name' do
      let(:input) do
        {
          name: '',
          email: 'jack@email.com'
        }
      end

      it 'does not create a new user and report errors' do
        expect(repository.all.count).to eq 0

        result = API::Schema.execute(query, variables:).to_h

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
