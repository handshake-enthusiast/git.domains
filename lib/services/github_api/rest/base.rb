# frozen_string_literal: true

module GithubAPI
  module REST
    class Base
      URL = 'https://api.github.com'

      def initialize(access_token:)
        @access_token = access_token
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
          Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = http_class.new(uri)
            headers.each do |header, value|
              req[header] = value
            end
            req.body = form_data.to_json unless form_data.nil?
            http.request(req)
          end
      end

      def uri
        @uri ||= URI("#{URL}#{path}")
      end

      def path
        raise 'must be implemented'
      end

      def http_class
        case http_method.upcase
        when 'GET' then Net::HTTP::Get
        when 'POST' then Net::HTTP::Post
        when 'PUT' then Net::HTTP::Put
        when 'DELETE' then Net::HTTP::Delete
        else raise 'Unsupported HTTP Method'
        end
      end

      def http_method
        'GET'
      end

      def headers
        {
          'Accept' => 'application/vnd.github+json',
          'Authorization' => "Bearer #{@access_token}",
          'User-Agent' => 'git.domains',
          'X-GitHub-Api-Version' => '2022-11-28'
        }
      end

      def form_data
        nil
      end
    end
  end
end
