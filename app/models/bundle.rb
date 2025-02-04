class Bundle
  attr_reader :quantity, :price

  def initialize(quantity, price)
    @quantity = quantity
    @price = price
  end

  def to_s(count)
    "#{count} x #{quantity} $#{price}"
  end

  def get_cost(count)
    count * price
  end
end