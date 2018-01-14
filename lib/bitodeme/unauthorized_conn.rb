require 'singleton'

module Bitodeme
  # HTTP Connection for Bitodeme unauthorized endpoints
  class UnauthorizedConn
    include Singleton

    USER_AGENT = "Ruby / Bitodeme::Conn v#{Bitodeme::VERSION}".freeze

    def self.build
      instance.send(:connection)
    end

    private

    def connection
      Faraday.new(faraday_opts) do |conn|
        conn.request  :json
        conn.response :json, content_type: /\bjson$/
        conn.response :logger
        conn.adapter  Faraday.default_adapter
      end
    end

    def faraday_opts
      @faraday_opts ||= {
        url:     "https://#{Bitodeme.config.hostname}",
        headers: { 'User-Agent' => USER_AGENT }
      }
    end
  end
end
