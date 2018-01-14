module Bitodeme
  module Resource
    # Invoice resource
    class Invoice < Base
      private_class_method :new

      # Account identifier
      attr_reader :account_id

      # Fund address
      attr_reader :address

      # Amount
      attr_reader :amount

      # Cancellation return url
      attr_reader :cancel_return_url

      # Created at in milliseconds
      attr_reader :created_at

      # Currency code
      attr_reader :currency_code

      # Current status
      attr_reader :current_status

      # Deleted at in milliseconds
      attr_reader :deleted_at

      # Description
      attr_reader :description

      # External unique identifier
      attr_reader :external_id

      # Unique identifier
      attr_reader :id

      # Name/title
      attr_reader :name

      # Notify url
      attr_reader :notify_url

      # Original amount
      attr_reader :original_amount

      # Original currency code
      attr_reader :original_currency_code

      # Is it purchasable
      attr_reader :purchasable

      # Successful payment return url
      attr_reader :return_url

      # Updated at in milliseconds
      attr_reader :updated_at

      class << self
        # Build an invoice
        #
        # Example:
        #   >> invoice =
        #   >>   Bitodeme::Resource::Invoice.build(
        #   >>     name:                   'Virtual game gold',
        #   >>     description:            'Buy a game gold',
        #   >>     original_amount:        16.7,
        #   >>     original_currency_code: 'USD',
        #   >>     external_id:            'SomeUniqId',
        #   >>     purchasable:            {}
        #   >>   )
        #
        # Arguments:
        #   params: (Hash)
        def build(params)
          new(params).send(:validate)
        end

        # Find an invoice
        #
        # Arguments:
        #   id: (UUID)
        def find(id)
          _find('invoices', 'invoice', id)
        end

        # Craete a new invoice
        #
        # Example:
        #   >> invoice =
        #   >>   Bitodeme.build_invoice(
        #   >>     name:                   'Virtual game gold',
        #   >>     description:            'Buy a game gold',
        #   >>     original_amount:        16.7,
        #   >>     original_currency_code: 'USD',
        #   >>     external_id:            'SomeUniqId',
        #   >>     purchasable:            {}
        #   >>   )
        #
        #   >> invoice = Bitodeme.create_invoice(invoice)
        #
        # Arguments:
        #   invoice: (Bitodeme::Resource::Invoice)
        def create(invoice)
          raise_for('invoice', invoice) unless invoice.is_a?(Invoice)
          _create('invoices', 'invoice', invoice: invoice.to_h)
        end

        private

        def unauthorized_conn
          Bitodeme::UnauthorizedConn.build
        end

        def raise_for(attr, val)
          raise Bitodeme::ValidationError.new(attr, val)
        end
      end

      private

      def_delegators :unauthorized_conn, :get

      def initialize(params)
        super(attrs: attrs, params: params)
      end

      def validate
        validate_original_amount
        validate_original_currency_code
        validate_external_id
        validate_purchasable
        self
      end

      def validate_original_amount
        return if /^\d{0,8}(\.\d{1,8})?$/.match?(original_amount.to_s)
        raise_for('original_amount')
      end

      def validate_original_currency_code
        return if /^[a-zA-Z]{3}$/.match?(original_currency_code.to_s)
        raise_for('original_currency_code')
      end

      def validate_external_id
        raise_for('external_id') unless external_id.is_a?(String)
      end

      def validate_purchasable
        raise_for('purchasable') unless purchasable.is_a?(Hash)
      end
    end
  end
end
