# frozen_string_literal: true

module Varo
  class AddRecord
    URL = 'https://varo.domains/api'

    def initialize(login:, varo_zone: VARO_ZONE, domain: DOMAIN)
      @login = login
      @varo_zone = varo_zone
      @domain = domain
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
      @response ||= Net::HTTP.post(
        URI(URL),
        request_body.to_json,
        { 'Authorization' => "Bearer #{VARO_API_KEY}", 'Content-Type' => 'application/json' }
      )
    end

    def request_body
      {
        action: 'addRecord',
        zone: @varo_zone,
        type: 'CNAME',
        name: "#{@login}.#{@domain}",
        content: "#{@login}.github.io"
      }
    end
  end
end
