require 'spec_helper'

RSpec.describe Bitodeme::UnauthorizedConn do
  describe '.build' do
    subject { described_class.build }

    it { is_expected.to be_a(Faraday::Connection) }
  end
end
