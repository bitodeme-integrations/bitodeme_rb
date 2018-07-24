require 'singleton'

module Bitodeme
  # HTTP Connection for Bitodeme unauthorized endpoints
  class UnauthorizedConn
    extend Forwardable
    include Singleton

    USER_AGENT = "Ruby / Bitodeme::Conn v#{Bitodeme::VERSION}".freeze

    def self.build
      instance.send(:connection)
    end

    private

    def_delegators :Bitodeme, :config
    def_delegators :config, :hostname, :logging

    def connection
      Faraday.new(faraday_opts) do |conn|
        conn.request  :json
        conn.response :logger if logging
        conn.response :json, content_type: /\bjson$/
        conn.adapter  Faraday.default_adapter
      end
    end

    def faraday_opts
      @faraday_opts ||= {
        url:     "https://#{hostname}",
        headers: { 'User-Agent' => USER_AGENT }
      }
    end
  end
end
