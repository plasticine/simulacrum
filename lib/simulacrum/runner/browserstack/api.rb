# encoding: UTF-8
require 'uri'
require 'net/https'

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
        response = make_request(url)
        JSON.parse(response.body)
      end

      def parse_url(url)
        URI.parse(url)
      end

      def prepare_http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.read_timeout = 30
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http
      end

      def make_request(url)
        uri = parse_url(url)
        http = prepare_http(uri)
        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(@username, @apikey)
        http.request(request)
      end
    end
  end
end
