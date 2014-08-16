require 'spec_helper'

describe PossibleEmail::Response do
  let(:response) { PossibleEmail.search('kevin', 'rose', 'gmail.com') }

  it 'returns an instance of Response' do
    expect(response).to be_instance_of(PossibleEmail::Response)
  end

  it 'returns entries' do
    expect(response.first).to be_instance_of(PossibleEmail::Profile)
  end
  describe '#[]' do
    it 'is able to receive [] to get a certain profile within' do
      expect(response[2]).to be_instance_of(PossibleEmail::Profile)
    end

    it 'returns nil when not within array' do
      expect(response[9999]).to be_nil
    end
  end
end
