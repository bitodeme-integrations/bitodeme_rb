require 'spec_helper'

RSpec.describe Bitodeme::Resource::Deposit do
  describe '#attrs' do
    subject { described_class.send(:new, {}) }

    let(:attrs) do
      %i[
        id
      ].freeze
    end

    let(:instance_attrs) { subject.send(:attrs).sort }

    it { expect(instance_attrs).to eq(attrs) }
  end

  describe '.all' do
    let(:opt) { {} }
    let(:collection) { 'deposits' }

    before do
      allow(described_class).to receive(:_all)
      described_class.all(opt)
    end

    it { expect(described_class).to have_received(:_all).with(collection, opt) }
  end
end
