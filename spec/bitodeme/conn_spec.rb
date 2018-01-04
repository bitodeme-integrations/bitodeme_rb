require 'spec_helper'

RSpec.describe Bitodeme::Conn do
  describe '.build' do
    subject { described_class.build }

    let(:auth) { instance_double(::Bitodeme::Auth, :token) }

    before do
      allow(Bitodeme::Auth).to receive(:build).and_return(auth)
      allow(auth).to receive(:token).and_return('fake')
    end

    it { is_expected.to be_a(Faraday::Connection) }
  end
end
