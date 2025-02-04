require 'rspec'
require_relative '../../app/models/order'

RSpec.describe Order do
  let(:product1_bundles) { [double(Bundle, quantity: 10, price: 12.99), double('Bundle', quantity: 5, price: 6.99)] }
  let(:product2_bundles) { [double(Bundle, quantity: 9, price: 24.95), double('Bundle', quantity: 6, price: 16.95), double('Bundle', quantity: 3, price: 9.95)] }
  let(:product3_bundles) { [double(Bundle, quantity: 9, price: 16.99), double('Bundle', quantity: 5, price: 9.95), double('Bundle', quantity: 3, price: 5.95)] }

  let(:product1) { double(Product, code: 'R12', bundles: product1_bundles) }
  let(:product2) { double(Product, code: 'L09', bundles: product2_bundles) }
  let(:product3) { double(Product, code: 'T58', bundles: product3_bundles) }

  let(:products) { [product1, product2, product3] }
  let(:order) { Order.new(order_lines, products) }

  describe '#processed_order' do
    subject { order.processed_order }

    context 'when the order lines are valid' do
      let(:order_lines) { ['10 R12', '15 L09', '13 T58'] }

      let(:expected_product1_bundles) { [[product1.bundles.first, 1]] }
      let(:expected_product2_bundles) { [[product2.bundles.first, 1], [product2.bundles[1], 1]] }
      let(:expected_product3_bundles) { [[product3.bundles.first, 1], [product3.bundles[2], 1]] }
      let(:expected_processed_order) do
        [
          { quantity: '10', code: 'R12', bundles: expected_product1_bundles, total_cost: 12.99 },
          { quantity: '15', code: 'L09', bundles: expected_product2_bundles, total_cost: 41.9 },
          { quantity: '13', code: 'T58', bundles: expected_product3_bundles, total_cost: 22.94 }
        ]
      end
    
      it 'processes the order lines correctly' do
        is_expected.to eq(expected_processed_order)
      end
    end

    context 'when all the order lines are invalid' do
      let(:order_lines) { ['5 X99', '5 Y99'] }

      it 'returns an empty array if no products match the order lines' do
        is_expected.to eq([])
      end
    end

    context 'when some order lines are invalid' do
      let(:order_lines) { ['5 X99', '25 R12'] }

      let(:expected_bundles) { [[product1.bundles.first, 2], [product1.bundles.last, 1]] }
      let(:expected_processed_order) do
        [
          { quantity: '25', code: 'R12', bundles: expected_bundles, total_cost: 32.97 }
        ]
      end

      it 'skips the order line if the product code is invalid' do
        is_expected.to eq(expected_processed_order)
      end
    end
  end
end