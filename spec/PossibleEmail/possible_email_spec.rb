require 'spec_helper'

describe PossibleEmail do
  describe '.search' do
    let(:find_any_email_search) { PossibleEmail.search('kevin', 'rose', 'gmail.com') }

    context 'when only one domain is given' do
      it 'returns an Response of Profiles' do
        expect(find_any_email_search).to be_instance_of(PossibleEmail::Response).and all be_instance_of(PossibleEmail::Profile)
      end

      it 'returns an Response with the correct number of Profiles' do
        expect(find_any_email_search.size).to eq(36)
      end
    end

    context 'when more than one domain is given' do
      context 'as splat arguments' do
        let(:find_any_email_search) { PossibleEmail.search('kevin', 'rose', 'example.com', 'gmail.com') }

        it 'does not raise an error' do
          expect { find_any_email_search }.not_to raise_error
        end

        it 'returns an Array with the correct number of Profiles' do
          expect(find_any_email_search.size).to eq(PATTERNS.split.size * 2) # two domains
        end

        it 'returns an Response of Profiles' do
          expect(find_any_email_search).to be_instance_of(PossibleEmail::Response).and all be_instance_of(PossibleEmail::Profile)
        end
      end

      context 'as an Array' do
        let(:domain) { ['example.com', 'gmail.com'] }
        let(:find_any_email_search) { PossibleEmail.search('kevin', 'rose', domain ) }

        it 'does not raise an error' do
          expect { find_any_email_search }.not_to raise_error
        end

        it 'returns an Response with the correct number of Profiles' do
          expect(find_any_email_search.size).to eq(PATTERNS.split.size * domain.size)
        end

        it 'returns an Response of Profiles' do
          expect(find_any_email_search).to be_instance_of(PossibleEmail::Response).and all be_instance_of(PossibleEmail::Profile)
        end
      end
    end
  end

  describe '.find_profile' do
    context 'when one email address is passed in' do
      context 'with correctly formatted email address' do
        it 'returns a single profile'do
          expect(PossibleEmail.find_profile('kevinrose@gmail.com')).to be_instance_of(PossibleEmail::Profile)
        end

        it 'does not return an Response' do
          expect(PossibleEmail.find_profile('kevinrose@gmail.com')).not_to be_instance_of(PossibleEmail::Response)
        end
      end

      context 'with incorrectly formatted email address' do
        it 'return the correct error' do
          expect { PossibleEmail.find_profile('@gmail.com') }.to raise_error(PossibleEmail::InvalidEmailFormat)
        end

        it 'return the correct error message' do
          expect { PossibleEmail.find_profile('@gmail.com').message }.to raise_error(PossibleEmail::InvalidEmailFormat, 'Email arguments were not formatted correctly ["@gmail.com"]')
        end
      end
    end

    context 'when more than one email address is passed in' do
      it 'accept an Array of email addresses' do
        expect { PossibleEmail.find_profile(['bob@gmail.com', 'jones@gmail.com']) }.not_to raise_error
      end

      it 'accept splat email address String arguments' do
        expect { PossibleEmail.find_profile('bob@gmail.com', 'jones@gmail.com') }.not_to raise_error
      end

      # it 'skips emails that are not formatted correctly'

      it 'returns an Response of Profiles' do
        expect(PossibleEmail.find_profile('bob@gmail.com', 'jones@gmail.com')).to be_instance_of(PossibleEmail::Response).and all be_instance_of(PossibleEmail::Profile)
      end
    end
  end
end
