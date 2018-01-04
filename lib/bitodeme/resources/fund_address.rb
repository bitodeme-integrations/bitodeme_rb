module Bitodeme
  module Resource
    # FundAddress resource
    class FundAddress < Base
      private_class_method :new

      # Account identifier
      attr_reader :account_id

      # Address (like Bank IBAN, or BTC address)
      attr_reader :address

      # Created at in milliseconds
      attr_reader :created_at

      # Currency code
      attr_reader :currency_code

      # Current status
      attr_reader :current_status

      # Fund id
      attr_reader :fund_id

      # Unique identifier
      attr_reader :id

      # Is it a temporary address?
      attr_reader :is_temporary

      # Updated at in milliseconds
      attr_reader :updated_at

      class << self
        # Find a fund address
        #
        # Arguments:
        #   id: (UUID)
        def find(id)
          _find('fund_addresses', 'fund_address', id)
        end

        # List all fund addresses
        #
        # Arguments:
        #   options: (Hash)
        def all(options = {})
          _all('fund_addresses', options)
        end
      end

      private

      def initialize(params)
        super(attrs: attrs, params: params)
      end
    end
  end
end
