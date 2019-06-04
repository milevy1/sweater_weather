require 'rails_helper'

describe User, type: :model do
  context 'Instance methods' do
    describe '#create_api_key' do
      subject { User.create(email: 'email', password_digest: 'password') }

      it 'creates an api key on the user' do
        subject.create_api_key

        expect(subject.api_key).to be_present
        expect(subject.api_key.length).to eq(32)
      end

      it 'returns the api_key' do
        expect(subject.create_api_key.length).to eq(32)
      end
    end
  end
end
