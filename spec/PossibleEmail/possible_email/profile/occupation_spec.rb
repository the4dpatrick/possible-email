require 'spec_helper'

describe PossibleEmail::Occupation do
  let(:occupation) do
    PossibleEmail::Occupation.new('job_title' => 'entrepreneur', 'company' => 'startup')
  end

  it 'returns the associated job_title' do
    expect(occupation.job_title).to eq('entrepreneur')
  end

  it 'returns the associated company' do
    expect(occupation.company).to eq('startup')
  end
end
