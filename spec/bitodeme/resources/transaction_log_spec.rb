require 'spec_helper'

RSpec.describe Bitodeme::Resource::TransactionLog do
  describe '#attrs' do
    subject { described_class.send(:new, {}) }

    let(:attrs) do
      %i[
        account_id
        amount
        created_at
        currency_code
        current_status
        description
        fund_id
        id
        transactable
        transactable_id
        transactable_type
        updated_at
      ].freeze
    end

    let(:instance_attrs) { subject.send(:attrs).sort }

    it { expect(instance_attrs).to eq(attrs) }
  end

  describe '.find' do
    let(:id) { '123456789' }
    let(:collection) { 'transaction_logs' }
    let(:resource) { 'transaction_log' }

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
    let(:collection) { 'transaction_logs' }

    before do
      allow(described_class).to receive(:_all)
      described_class.all(opt)
    end

    it { expect(described_class).to have_received(:_all).with(collection, opt) }
  end
end
