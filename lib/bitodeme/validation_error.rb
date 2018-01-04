module Bitodeme
  # Validation Error
  class ValidationError < StandardError
    def initialize(attr, val)
      super("Unacceptable value('#{val}') for '#{attr}'!")
    end
  end
end
