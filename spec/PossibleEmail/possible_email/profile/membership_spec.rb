require 'spec_helper'

describe PossibleEmail::Membership do
  let(:membership) do
    PossibleEmail::Membership.new('profile_url' => 'http://www.facebook.com/profile',
                                 'profile_id' => '1234',
                                 'username' => 'profile',
                                 'site_name' => 'Facebook')
  end

  it 'returns the associated profile_url' do
    expect(membership.profile_url).to eq('http://www.facebook.com/profile')
  end

  it 'returns the associated profile_id' do
    expect(membership.profile_id).to eq('1234')
  end

  it 'returns the associated username' do
    expect(membership.username).to eq('profile')
  end

  it 'returns the associated site_name' do
    expect(membership.site_name).to eq('Facebook')
  end
end
