require 'singleton'

module Bitodeme
  # HTTP Connection for Bitodeme
  class Conn
    extend Forwardable
    include Singleton

    USER_AGENT = "Ruby / Bitodeme::Conn v#{Bitodeme::VERSION}".freeze

    def self.build
      instance.send(:connection)
    end

    private

    attr_reader :auth

    def_delegators :Bitodeme, :config
    def_delegators :config, :hostname, :logging

    def initialize
      @auth = Bitodeme::Auth.build
    end

    def connection
      Faraday.new(faraday_opts) do |conn|
        conn.request  :oauth2, auth.token, token_type: :bearer
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
