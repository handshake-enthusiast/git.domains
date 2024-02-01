# frozen_string_literal: true

module Github
  module OAuth
    class AccessToken
      URL = 'https://github.com/login/oauth/access_token'

      def initialize(code:)
        @code = code
      end

      def call
        formatted_response
      end

      protected

      def formatted_response
        response_body = response.body
        {
          headers: response.each_header.to_h,
          body: response_body.nil? ? nil : JSON.parse(response_body),
          status: response.code.to_i
        }
      end

      def response
        @response ||=
          Net::HTTP.post(
            URI(URL),
            URI.encode_www_form(params),
            { 'Accept' => 'application/json', 'User-Agent' => 'git.domains' }
          )
      end

      def params
        {
          'client_id' => GITHUB_OAUTH_CLIENT_ID,
          'client_secret' => GITHUB_OAUTH_CLIENT_SECRET,
          'code' => @code
        }
      end
    end
  end
end
