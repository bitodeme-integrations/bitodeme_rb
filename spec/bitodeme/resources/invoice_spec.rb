require 'spec_helper'

RSpec.describe Bitodeme::Resource::Invoice do
  describe '#attrs' do
    subject { described_class.send(:new, {}) }

    let(:attrs) do
      %i[
        account_id
        address
        amount
        cancel_return_url
        created_at
        currency_code
        current_status
        deleted_at
        description
        external_id
        id
        name
        notify_url
        original_amount
        original_currency_code
        purchasable
        return_url
        updated_at
      ].freeze
    end

    let(:instance_attrs) { subject.send(:attrs).sort }

    it { expect(instance_attrs).to eq(attrs) }
  end

  describe '.find' do
    let(:id) { '123456789' }
    let(:collection) { 'invoices' }
    let(:resource) { 'invoice' }

    before do
      allow(described_class).to receive(:_find)
      described_class.find(id)
    end

    it do
      expect(described_class).to have_received(:_find)
        .with(collection, resource, id)
    end
  end

  describe '.create' do
    let(:collection) { 'invoices' }
    let(:resource) { 'invoice' }
    let(:invoice) { described_class.send(:new, {}) }
    let(:validation_error) { Bitodeme::ValidationError }

    it 'passes instance validation and calls `_create`' do
      allow(described_class).to receive(:_create)
      expect(described_class).to receive(:_create)
        .with(collection, resource, invoice: {})
      described_class.create(invoice)
    end

    it 'raises error' do
      expect { described_class.create({}) }.to raise_error(validation_error)
    end
  end
end
