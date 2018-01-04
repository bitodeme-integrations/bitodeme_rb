require 'spec_helper'

RSpec.describe Bitodeme::Resource::FundAddress do
  describe '#attrs' do
    subject { described_class.send(:new, {}) }

    let(:attrs) do
      %i[
        account_id
        address
        created_at
        currency_code
        current_status
        fund_id
        id
        is_temporary
        updated_at
      ].freeze
    end

    let(:instance_attrs) { subject.send(:attrs).sort }

    it { expect(instance_attrs).to eq(attrs) }
  end

  describe '.find' do
    let(:id) { '123456789' }
    let(:collection) { 'fund_addresses' }
    let(:resource) { 'fund_address' }

    before do
      allow(described_class).to receive(:_find)
      described_class.find(id)
    end

    it do
      expect(described_class).to have_received(:_find)
        .with(collection, resource, id)
    end
  end

  describe '.all' do
    let(:opt) { {} }
    let(:collection) { 'fund_addresses' }

    before do
      allow(described_class).to receive(:_all)
      described_class.all(opt)
    end

    it { expect(described_class).to have_received(:_all).with(collection, opt) }
  end
end
