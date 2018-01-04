module Bitodeme
  module Resource
    # TransactionLog resource
    class TransactionLog < Base
      private_class_method :new

      # Account identifier
      attr_reader :account_id

      # Amount
      attr_reader :amount

      # Created at in milliseconds
      attr_reader :created_at

      # Currency code
      attr_reader :currency_code

      # Current status
      attr_reader :current_status

      # Description
      attr_reader :description

      # Fund identifier
      attr_reader :fund_id

      # Unique identifier
      attr_reader :id

      # Transaction detail
      attr_reader :transactable

      # Polymorphic relation identifier for transaction
      attr_reader :transactable_id

      # Polymorphic relation type for transaction
      attr_reader :transactable_type

      # Updated at in milliseconds
      attr_reader :updated_at

      class << self
        # Find a transaction log
        #
        # Arguments:
        #   id: (UUID)
        def find(id)
          _find('transaction_logs', 'transaction_log', id)
        end

        # List all transaction logs
        #
        # Arguments:
        #   options: (Hash)
        def all(options = {})
          _all('transaction_logs', options)
        end
      end

      private

      def initialize(params)
        super(attrs: attrs, params: params)
      end
    end
  end
end
