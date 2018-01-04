require 'spec_helper'

RSpec.describe Bitodeme::Configuration do
  describe '.instance' do
    subject { described_class.build }

    let(:hostname) { 'alpha.bitodeme.com' }
    let(:client_id) { 'key' }
    let(:client_secret) { 'secret' }

    it { expect(subject.hostname).to eq(hostname) }
    it { expect(subject.client_id).to eq(client_id) }
    it { expect(subject.client_secret).to eq(client_secret) }
  end
end
