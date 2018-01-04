module Bitodeme
  module Resource
    # Currency resource
    class Currency < Base
      private_class_method :new

      # Short code and unique identifier
      attr_reader :code

      # When it is created
      attr_reader :created_at

      # Current status
      attr_reader :current_status

      # Deposit fee
      attr_reader :deposit_fee

      # Is it depositable?
      attr_reader :depositable

      # Is it open for exchange?
      attr_reader :exchangeable

      # Minimum depositable amount
      attr_reader :min_depositable_amount

      # Minimum withdrawable amount
      attr_reader :min_withdrawable_amount

      # Full name
      attr_reader :name

      # Last updated at
      attr_reader :updated_at

      # Withdraw fee
      attr_reader :withdraw_fee

      # Is it withdrawable?
      attr_reader :withdrawable

      class << self
        # List all currencies
        #
        # Arguments:
        #   options: (Hash)
        def all(options = {})
          _all('currencies', options)
        end
      end

      private

      def initialize(params)
        super(attrs: attrs, params: params)
      end
    end
  end
end
