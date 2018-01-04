module Bitodeme
  module Resource
    # Deposit resource
    class Deposit < Base
      private_class_method :new

      # Unique identifier
      attr_reader :id

      class << self
        # List all deposits
        #
        # Arguments:
        #   options: (Hash)
        def all(options = {})
          _all('deposits', options)
        end
      end

      private

      def initialize(params)
        super(attrs: attrs, params: params)
      end
    end
  end
end
