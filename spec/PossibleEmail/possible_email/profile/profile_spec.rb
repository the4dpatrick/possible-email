require 'spec_helper'

describe PossibleEmail::Profile do
  let(:data) { JSON.parse(File.read(File.expand_path('spec/fixtures/rapportive_example_data.json'))) }
  let(:profile) { PossibleEmail::Profile.new(data) }

  it 'returns an error if no data is given' do
    expect { PossibleEmail::Profile.new({}) }.to raise_error(PossibleEmail::NoDataError)
  end

  describe '#attributes' do
    it 'returns a list of available' do
      expect(profile.attributes).to eq(["email", "name", "first_name", "last_name", "friendly_name", "location", "headline", "success", "occupations", "memberships", "images", "phones"])
    end
  end

  describe '#to_s' do
    it 'returns formatted name and email' do
      expect(profile.to_s).to eq('Kevin Rose - kevinrose@gmail.com')
    end
  end

  describe 'Profile Attributes' do
    it 'returns the associated email address' do
      expect(profile.data).to be_instance_of(Hash)
    end

    it 'returns the associated email address' do
      expect(profile.email).to eq('kevinrose@gmail.com')
    end

    it 'returns the associated name' do
      expect(profile.name).to eq('Kevin Rose')
    end

    it 'returns the associated first name' do
      expect(profile.first_name).to eq('Kevin')
    end

    it 'returns the associated last name' do
      expect(profile.last_name).to eq('Rose')
    end

    it 'returns the associated friendly_name' do
      expect(profile.friendly_name).to eq('Kevin')
    end

    it 'returns the associated locaiton' do
      expect(profile.location).to eq('San Francisco Bay Area')
    end

    it 'returns the associated headline' do
      expect(profile.headline).to eq('General Partner at Google Ventures')
    end

    it 'returns the type of success' do
      expect(profile.success).to eq('image_and_occupation_and_useful_membership')
    end

    describe 'occupations' do
      it 'returns an array with the correct number of occupations' do
        expect(profile.occupations.size).to eq(2)
      end

      it 'returns an array of Occupation instances' do
        expect(profile.occupations).to all be_instance_of(PossibleEmail::Occupation)
      end
    end

    describe 'images' do
      it 'returns an array with the correct number of images' do
        expect(profile.images.size).to eq(12)
      end

      it 'returns an array of Image instances' do
        expect(profile.images).to all be_instance_of(PossibleEmail::Image)
      end
    end

    describe 'memberships' do
      it 'returns an array with the correct number of memberships' do
        expect(profile.memberships.size).to eq(18)
      end

      it 'returns an array of Memberships instances' do
        expect(profile.memberships).to all be_instance_of(PossibleEmail::Membership)
      end
    end

    # describe 'phones' do
    #   it 'returns an array with the correct number of memberships' do
    #     expect(profile.phones.size).to eq(0)
    #   end

    #   it 'returns an array of Memberships instances' do
    #     expect(profile.phones).to all be_instance_of(PossibleEmail::Phone)
    #   end
    # end
  end
end
