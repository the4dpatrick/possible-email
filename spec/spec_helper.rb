require 'coveralls'
Coveralls.wear!

require 'possible_email'

RSpec.configure do |config|
  config.before do
    allow(PossibleEmail::ResponseGetter).to receive(:request_url) do
      JSON.parse(File.read(File.expand_path('spec/fixtures/rapportive_example_data.json')))
    end
  end
end
