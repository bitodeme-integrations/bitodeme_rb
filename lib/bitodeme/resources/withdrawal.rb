module Bitodeme
  module Resource
    # Withdrawal resource
    class Withdrawal < Base
      private_class_method :new

      # Address
      attr_reader :address

      # Amount
      attr_reader :amount

      # Fund identifier
      attr_reader :fund_id

      # Unique identifier
      attr_reader :id

      # One time password value gathered from Google Authenticator
      attr_reader :otp_value

      class << self
        # Build a withdrawal object
        #
        # Example:
        #   >> fund_id    = '12b241a7-941e-43a8-878e-a467809e988e'
        #   >> withdrawal =
        #   >>   Bitodeme::Resource::Withdrawal.build(
        #   >>     amount:    0.0013,
        #   >>     address:   'morg4YKzAESEktS7H74dtaavFjuhNUi8zq',
        #   >>     fund_id:   fund_id,
        #   >>     otp_value: "123456" # otp value from Google Authenticator
        #   >>   )
        #
        # Arguments:
        #   params: (Hash)
        def build(params)
          new(params).send(:validate)
        end

        # Craete a new withdrawal(send money)
        #
        # Example:
        #   >> fund_id    = '12b241a7-941e-43a8-878e-a467809e988e'
        #   >> withdrawal =
        #   >>   Bitodeme::Resource::Withdrawal.build(
        #   >>     amount:    0.0013,
        #   >>     address:   'morg4YKzAESEktS7H74dtaavFjuhNUi8zq',
        #   >>     fund_id:   fund_id,
        #   >>     otp_value: "123456" # otp value from Google Authenticator
        #   >>   )
        #
        #   >> Bitodeme::Resource::Withdrawal.create(withdrawal)
        #
        # Arguments:
        #   withdrawal: (Bitodeme::Resource::Withdrawal)
        def create(withdrawal)
          raise_for('withdrawal', withdrawal) unless withdrawal.is_a?(Withdrawal)
          data = { withdrawal: withdrawal.to_h }
          post('/api/v1/withdrawals', data).body
        end

        private

        def raise_for(attr, val)
          raise Bitodeme::ValidationError.new(attr, val)
        end
      end

      private

      def initialize(params)
        super(attrs: attrs, params: params)
      end

      def validate
        validate_address
        validate_amount
        validate_fund_id
        validate_otp_value
        self
      end

      def validate_address
        raise_for('address') unless address.is_a?(String)
      end

      # TODO: Validate with UUID format
      def validate_fund_id
        raise_for('fund_id') unless fund_id.is_a?(String)
      end

      def validate_amount
        raise_for('amount') unless /^\d{0,8}(\.\d{1,8})?$/.match?(amount.to_s)
      end

      def validate_otp_value
        raise_for('otp_value') unless /^\d{6}$/.match?(otp_value.to_s)
      end
    end
  end
end
