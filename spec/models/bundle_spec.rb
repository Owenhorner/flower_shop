require 'rspec'
require_relative '../../app/models/bundle'

RSpec.describe Bundle do
  subject { described_class.new(5, 10.0) }

  context 'when initialized' do
    it 'sets the quantity' do
      is_expected.to have_attributes(quantity: 5)
    end

    it 'sets the price' do
      is_expected.to have_attributes(price: 10.0)
    end
  end

  describe '#to_s' do
    it 'returns the correct string representation' do
      expect(subject.to_s(3)).to eq('3 x 5 $10.0')
    end
  end

  describe '#get_cost' do
    it 'calculates the correct cost' do
      expect(subject.get_cost(3)).to eq(30.0)
    end
  end
end