require 'forwardable'

module Bitodeme
  # OAuth2 client credentials authenticator for Bitodeme
  class Auth
    extend Forwardable
    include Singleton

    def self.build
      $bitodeme_auth ||= instance
    end

    # Valid access token for Bitodeme endpoints
    def token
      reset_token if expired?
      access_token
    end

    def inspect
      "#<#{self.class.name}:0x#{(object_id << 1).to_s(16)} " \
        "hostname=\"#{hostname}\" client_id=\"#{client_id}\" " \
        "client_secret=\"#{client_secret}\">"
    end

    private

    GRANT_TYPE = 'client_credentials'.freeze
    USER_AGENT = "Ruby / Bitodeme::Auth v#{Bitodeme::VERSION}".freeze

    def_delegators :Bitodeme, :config
    def_delegators :config, :hostname, :client_id, :client_secret, :logging

    attr_reader :connection, :access_token, :expires_at

    def initialize
      @connection   = build_connection
      @expires_at   = 0
      @access_token = ''
    end

    def expired?
      Time.now.to_i >= expires_at
    end

    def reset_token
      token         = authenticate.fetch('token', {})
      @access_token = token.fetch('value', '')
      @expires_at   = token.fetch('expires_at', 0)
    end

    def authenticate
      connection.post('/api/v1/tokens', auth_body).body
    end

    def build_connection
      Faraday.new(faraday_opts) do |conn|
        conn.request  :json
        conn.response :logger if logging
        conn.response :json, content_type: /\bjson$/
        conn.adapter  Faraday.default_adapter
      end
    end

    def faraday_opts
      {
        url:     "https://#{hostname}",
        headers: { 'User-Agent' => USER_AGENT }
      }
    end

    def auth_body
      @auth_body ||= { token: auth_params }
    end

    def auth_params
      {
        client_id:     client_id,
        client_secret: client_secret,
        grant_type:    GRANT_TYPE
      }
    end
  end
end
