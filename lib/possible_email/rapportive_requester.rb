require 'possible_email/response'
require 'possible_email/response_getter'
require 'possible_email/profile/profile'

module PossibleEmail
  class RapportiveRequester
    def self.request(*emails)
      new(emails).request
    end

    def initialize(emails)
      @emails = emails.flatten
    end

    def request
      email_profiles = accumulate_email_profiles

      puts # newline after ...F... HACK

      response = Response.new(email_profiles)
      response.size == 1 ? response.first : response
    end

    private

    # HACK
    def accumulate_email_profiles
      @emails.reduce([]) do |profiles, email|
        profile = create_profile_for_email(email)
        print profile ? '.' : 'F'
        profiles << profile
      end
    end

    def create_profile_for_email(email)
      session_token = ResponseGetter.create_session_token(email)
      return unless session_token

      response = ResponseGetter.retrieve_email_profile_using_session_token(email, session_token)
      return unless response

      Profile.new(response) if useful_response?(response)
    end

    def useful_response?(response)
      response['contact'] && response['success'] != 'nothing_useful' && response['status'] != 403
    end
  end
end
