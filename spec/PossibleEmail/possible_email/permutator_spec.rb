require 'spec_helper'

describe PossibleEmail::Permutator do

  describe '.call' do

    context 'when one domain is given' do
      let(:permutations) { PossibleEmail::Permutator.call('kevin', 'rose', 'gmail.com') }

      it 'returns an array' do
        expect(permutations).to be_instance_of(Array)
      end

      it 'returns an array equal in size to every pattern in PATTERNS' do
        expect(permutations.size).to eq(PATTERNS.split.size)
      end

      it 'replaces all placeholder patterns' do
        expect(permutations.to_s).not_to match(/[\{\}]+/)
      end
    end

    context 'when multiple domains are given' do

      context 'as splat String arguments' do
        let(:permutations) { PossibleEmail::Permutator.call('kevin', 'rose', 'gmail.com', 'yahoo.com') }

        it 'returns an array' do
          expect(permutations).to be_instance_of(Array)
        end

        it 'returns an array equal in size to all permutations created with PATTERNS' do
          expect(permutations.size).to eq(PATTERNS.split.size * 2) # two domains
        end

        it 'replaces all placeholder patterns' do
          expect(permutations.to_s).not_to match(/[\{\}]+/)
        end

        it 'has the correct number of `yahoo.com` emails' do
          yahoo_email_count = permutations.to_s.scan(/yahoo\.com/).size

          expect(yahoo_email_count).to eq(PATTERNS.split.size)
        end

        it 'has the correct number of `gmail.com` emails' do
          gmail_email_count = permutations.to_s.scan(/gmail\.com/).size

          expect(gmail_email_count).to eq(PATTERNS.split.size)
        end
      end

      context 'as an Array' do
        let(:domains) { ['gmail.com', 'yahoo.com'] }
        let(:permutations) { PossibleEmail::Permutator.call('kevin', 'rose', domains) }

        it 'returns an array' do
          expect(permutations).to be_instance_of(Array)
        end

        it 'returns an array equal in size to every pattern in PATTERNS' do
          expect(permutations.size).to eq(PATTERNS.split.size * domains.size) # two domains
        end

        it 'replaces all placeholder patterns' do
          expect(permutations.to_s).not_to match(/[\{\}]+/)
        end

        it 'has the correct number of `yahoo.com` emails' do
          yahoo_email_count = permutations.to_s.scan(/yahoo\.com/).size

          expect(yahoo_email_count).to eq(PATTERNS.split.size)
        end

        it 'has the correct number of `gmail.com` emails' do
          gmail_email_count = permutations.to_s.scan(/gmail\.com/).size

          expect(gmail_email_count).to eq(PATTERNS.split.size)
        end
      end
    end
  end
end
