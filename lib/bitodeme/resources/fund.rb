module Bitodeme
  module Resource
    # Fund resource
    class Fund < Base
      private_class_method :new

      # Account identifier
      attr_reader :account_id

      # Current balance
      attr_reader :amount

      # When it is created
      attr_reader :created_at

      # Currency code
      attr_reader :currency_code

      # Current status
      attr_reader :current_status

      # Unique identifier
      attr_reader :id

      # Updated at in milliseconds
      attr_reader :updated_at

      class << self
        # Find a fund
        #
        # Arguments:
        #   id: (UUID)
        def find(id)
          _find('funds', 'fund', id)
        end

        # List all funds
        #
        # Arguments:
        #   options: (Hash)
        def all(options = {})
          _all('funds', options)
        end
      end

      private

      def initialize(params)
        super(attrs: attrs, params: params)
      end
    end
  end
end
