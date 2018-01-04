require 'spec_helper'

RSpec.describe Bitodeme::Resource::Withdrawal do
  describe '#attrs' do
    subject { described_class.send(:new, {}) }

    let(:attrs) do
      %i[
        address
        amount
        fund_id
        id
        otp_value
      ].freeze
    end

    let(:instance_attrs) { subject.send(:attrs).sort }

    it { expect(instance_attrs).to eq(attrs) }
  end

  describe '.create' do
    let(:withdrawal) { described_class.send(:new, {}) }
    let(:validation_error) { Bitodeme::ValidationError }
    let(:response) { instance_double('Faraday::Response', body: {}) }

    it 'passes instance validation and calls `post`' do
      allow(described_class).to receive(:post).and_return(response)
      expect(described_class).to receive(:post)
        .with('/api/v1/withdrawals', withdrawal: {})
        .and_return(response)
      described_class.create(withdrawal)
    end

    it 'raises error' do
      expect { described_class.create({}) }.to raise_error(validation_error)
    end
  end
end
