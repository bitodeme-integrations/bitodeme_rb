require 'spec_helper'

RSpec.describe Bitodeme::ValidationError do
  describe '.raise' do
    it 'matches the error message' do
      expect { raise described_class.new('age', -1) }
        .to raise_error('Unacceptable value(\'-1\') for \'age\'!')
    end
  end
end
