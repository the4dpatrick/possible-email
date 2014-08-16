require 'spec_helper'

describe PossibleEmail::ResponseGetter do

  describe '.create_session_token' do
    context 'when valid response' do
      it 'returns a session token' do
        expect(PossibleEmail::ResponseGetter.create_session_token('bob@gmail.com')).to be_instance_of(String)
      end
    end

    context 'when an invalid response' do
      context 'and response is nil' do
        it 'returns nil' do
          allow(PossibleEmail::ResponseGetter).to receive(:valid_response?).and_return(nil)
          expect(PossibleEmail::ResponseGetter.create_session_token('bob@gmail.com')).to be_nil
        end
      end

      context 'and theres an error ' do
        it 'returns nil' do
          allow(PossibleEmail::ResponseGetter).to receive(:request_url).and_return('error' => true, 'status' => 200)
          expect(PossibleEmail::ResponseGetter.create_session_token('bob@gmail.com')).to be_nil
        end
      end

      context 'and status is not 200' do
        it 'returns nil' do
          allow(PossibleEmail::ResponseGetter).to receive(:request_url).and_return('status' => 400)
          expect(PossibleEmail::ResponseGetter.create_session_token('bob@gmail.com')).to be_nil
        end
      end
    end
  end

  describe '.retrieve_email_profile_using_session_token' do
    context 'when valid response' do
      it 'returns a response' do
        expect(PossibleEmail::ResponseGetter.retrieve_email_profile_using_session_token('bob@gmail.com', 'session')).to be_instance_of(Hash)
      end
    end

    context 'when invalid response' do
      it 'returns nil' do
        allow(PossibleEmail::ResponseGetter).to receive(:request_url).and_return(nil)
        expect(PossibleEmail::ResponseGetter.retrieve_email_profile_using_session_token('bob@gmail.com', 'session')).to be_nil
      end
    end
  end
end
