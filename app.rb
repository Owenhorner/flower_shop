require 'roda'
require_relative 'app/models/product'
require_relative 'app/models/order'
require_relative 'app/models/bundle'

class App < Roda
  plugin :render, views: 'app/views', layout: nil

  route do |r|
    r.root do
      view('index', locals: { processed_order: [] })
    end

    r.post do
      order_lines = r.params['order_lines'].split("\n")
      order = Order.new(order_lines)
      render('index', locals: { processed_order: order.processed_order })
    end
  end
end