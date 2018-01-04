RSpec.describe Bitodeme do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  it '.config' do
    expect(described_class.config).to be_a(Bitodeme::Configuration)
  end
end
