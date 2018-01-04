require 'spec_helper'

RSpec.describe Bitodeme::Auth do
  subject { described_class.build }

  describe '.build' do
    let(:connection) { subject.send(:connection) }
    let(:expires_at) { subject.send(:expires_at) }
    let(:access_token) { subject.send(:access_token) }

    it { expect(connection).to be_a(Faraday::Connection) }
    it { expect(expires_at).to eq(0) }
    it { expect(access_token).to eq('') }
  end

  describe '#token' do
    describe 'makes a request to fetch token' do
      let(:token) { subject.token }

      before { VCR.use_cassette('oauth2_client_credentials') { token } }

      it 'sets access_token and expires_at' do
        expect(subject.send(:access_token)).to eq(token)
        expect(subject.send(:access_token)).not_to be_empty
        expect(subject.send(:expires_at)).not_to eq(0)
      end
    end

    describe 'does not make a new request unless token expired?' do
      let(:token) { 'immortal' }

      before do
        subject.instance_variable_set(:@access_token, token)
        subject.instance_variable_set(:@expires_at, Time.now.to_i + 3600)
        subject.token
      end

      it { expect(subject.token).to eq(token) }
      it { expect(subject.send(:access_token)).to eq(token) }
    end
  end
end
