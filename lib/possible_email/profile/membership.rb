module PossibleEmail
  class Membership
    attr_reader :profile_url, :profile_id, :username, :site_name

    def initialize(data)
      @profile_url = data['profile_url']
      @profile_id = data['profile_id']
      @username = data['username']
      @site_name = data['site_name']
    end
  end
end
