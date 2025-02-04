require 'rspec'
require_relative '../../app/models/product'

RSpec.describe Product do
  let(:bundle1) { double(Bundle, quantity: 5, price: 6.99) }
  let(:bundle2) { double(Bundle, quantity: 10, price: 12.99) }
  let(:bundles) { [bundle1, bundle2] }
  subject { Product.new('Roses', 'R12', bundles) }

  context 'when initialized' do
    it 'has a name' do
      is_expected.to have_attributes(name: 'Roses')
    end

    it 'has a code' do
      is_expected.to have_attributes(code: 'R12')
    end

    it 'has sorted bundles' do
      is_expected.to have_attributes(bundles: bundles.sort_by(&:quantity).reverse)
    end
  end

  describe '.all' do
    before do
      allow(YAML).to receive(:load_file).and_return({
        'products' => [
          {
            'name' => 'Roses',
            'code' => 'R12',
            'bundles' => [
              { 'quantity' => 5, 'price' => 6.99 },
              { 'quantity' => 10, 'price' => 12.99 }
            ]
          }
        ]
      })
    end

    it 'loads all products from the YAML file' do
      products = Product.all
      expect(products.length).to eq(1)
      expect(products.first.name).to eq('Roses')
      expect(products.first.code).to eq('R12')
      expect(products.first.bundles.length).to eq(2)
    end
  end
end