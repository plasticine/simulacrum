# encoding: UTF-8

module Simulacrum
  module Browserstack
    # The Browserstack API class wraps up functionality for talking to the
    # Browserstack REST API.
    class API
      def initialize(username, apikey)
        @username = username
        @apikey = apikey
      end

      def account_details
        request = request('https://www.browserstack.com/automate/plan.json')
        account_details = OpenStruct.new
        account_details.sessions_running = request['parallel_sessions_running'].to_i
        account_details.sessions_allowed = request['parallel_sessions_max_allowed'].to_i
        account_details
      end

      private

      def request(url)
        curl = Curl::Easy.new(url)
        curl.http_auth_types = :basic
        curl.username = @username
        curl.password = @apikey
        curl.perform
        JSON.parse(curl.body_str)
      end
    end
  end
end
