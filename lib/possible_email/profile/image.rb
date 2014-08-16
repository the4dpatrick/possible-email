module PossibleEmail
  class Image
    attr_reader :url, :service, :url_proxied

    def initialize(data)
      @url = data['url']
      @service = data['service']
      @url_proxied = data['url_proxied']
    end
  end
end
