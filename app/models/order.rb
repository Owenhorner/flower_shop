class Order
  attr_reader :processed_order, :order_lines

  def initialize(order_lines, products = Product.all)
    @products = products
    @order_lines = order_lines
  end

  def processed_order
    order_lines.map { |order_line| process_order_line(order_line) }.compact
  end

  private

  def process_order_line(order_line)
    quantity, code = order_line.split
    product = @products.find { |product| product.code == code }
    return unless product

    bundles = calculate_bundles(product.bundles, quantity.to_i)
    total_cost = calculate_total_cost(bundles)
    { quantity:, code:, bundles:, total_cost: }
  end

  def calculate_bundles(bundles, quantity)
    bundles.each_with_object([]) do |bundle, acc|
      count = quantity / bundle.quantity
      next if count <= 0

      acc << [bundle, count]
      quantity %= bundle.quantity
    end
  end

  def calculate_total_cost(bundles)
    bundles.sum { |bundle| bundle.last * bundle.first.price }.round(2)
  end
end