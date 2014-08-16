require 'spec_helper'

describe PossibleEmail::RapportiveRequester do

  describe '.request' do
    context 'when one email is passed in' do
      let(:rapportive_requester) { PossibleEmail::RapportiveRequester.request('bob@gmail.com') }

      it 'does not return an error' do
        expect { rapportive_requester }.not_to raise_error
      end

      it 'returns a single Profile' do
        expect(rapportive_requester).to be_instance_of(PossibleEmail::Profile)
      end
    end

    context 'when more than one email are passed in' do
      context 'as splat String arguments' do
        let(:rapportive_requester) { PossibleEmail::RapportiveRequester.request('bob@gmail.com', 'kevinrose@gmail.com') }

        it 'does not return an error' do
          expect { rapportive_requester }.not_to raise_error
        end

        it 'returns a Response instance' do
          expect(rapportive_requester).to be_instance_of(PossibleEmail::Response)
        end

        it 'returns a Response of the correct size' do
          expect(rapportive_requester.size).to eq(2)
        end
      end

      context 'as an Array' do
        let(:data) { ['bob@gmail.com', 'kevinrose@gmail.com'] }
        let(:rapportive_requester) { PossibleEmail::RapportiveRequester.request(data) }

        it 'does not return an error' do
          expect { rapportive_requester }.not_to raise_error
        end

        it 'returns a Response instance' do
          expect(rapportive_requester).to be_instance_of(PossibleEmail::Response)
        end

        it 'returns a Response of the correct size' do
          expect(rapportive_requester.size).to eq(2)
        end
      end
    end
  end

  describe '#create_profile_for_email' do
    it 'returns an empty array if no session token was received' do
      allow(PossibleEmail::ResponseGetter).to receive(:create_session_token).and_return(nil)

      expect(PossibleEmail::RapportiveRequester.request('bob@gmail.com')).to be_empty
    end

    it 'returns an empty array if invalid response' do
      allow(PossibleEmail::ResponseGetter).to receive(:retrieve_email_profile_using_session_token).and_return(nil)

      expect(PossibleEmail::RapportiveRequester.request('bob@gmail.com')).to be_empty
    end
  end
end
