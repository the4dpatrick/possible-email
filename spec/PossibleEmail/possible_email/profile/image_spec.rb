require 'spec_helper'

describe PossibleEmail::Image do
  let(:image) do PossibleEmail::Image.new('url' => 'image_url',
                                         'service' => 'Facebook',
                                         'url_proxied' => 'url_proxied')
  end

  it 'returns the associated url' do
    expect(image.url).to eq('image_url')
  end

  it 'returns the associated service' do
    expect(image.service).to eq('Facebook')
  end

  it 'returns the associated url_proxied' do
    expect(image.url_proxied).to eq('url_proxied')
  end
end
