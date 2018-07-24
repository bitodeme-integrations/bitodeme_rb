require 'singleton'

module Bitodeme
  # Configuration for Bitodeme
  class Configuration
    include Singleton

    attr_reader :hostname,
                :client_id,
                :client_secret,
                :logging

    def self.build
      $bitodeme_configuration ||= instance
    end

    private

    def initialize
      @hostname      = ENV['BITODEME_HOSTNAME']
      @client_id     = ENV['BITODEME_CLIENT_ID']
      @client_secret = ENV['BITODEME_CLIENT_SECRET']
      @logging       = ENV['BITODEME_CLIENT_LOGGING']
    end
  end
end
