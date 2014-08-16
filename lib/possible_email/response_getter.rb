STATUS_URL = 'https://rapportive.com/login_status?user_email='
PROFILE_URL = 'https://profiles.rapportive.com/contacts/email/'

module PossibleEmail
  class ResponseGetter
    class << self
      def create_session_token(email)
        status_url = STATUS_URL + email
        response = request_url status_url

        valid_response?(response) ? response['session_token'] : nil
      end

      def retrieve_email_profile_using_session_token(email, session_token)
        profile_url = PROFILE_URL + email
        header = { 'X-Session-Token' => session_token }
        response = request_url profile_url, header

        response.nil? ? nil : response
      end

      private

      def request_url(url, header = {})
        request = HTTPI::Request.new
        request.url = url
        request.headers = header

        JSON.parse(HTTPI.get(request).body)
      end

      def valid_response?(response)
        response['error'].nil? && response['status'] == 200
      end
    end
  end
end
