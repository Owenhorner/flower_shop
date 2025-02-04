require 'yaml'

class Product
  attr_reader :name, :code, :bundles

  def initialize(name, code, bundles)
    @name = name
    @code = code
    @bundles = bundles.sort_by(&:quantity).reverse
  end

  def self.all
    data = YAML.load_file('app/db/products.yaml')
    data['products'].map do |product_data|
      bundles = product_data['bundles'].map do |bundle_data|
        Bundle.new(bundle_data['quantity'], bundle_data['price'])
      end
      new(product_data['name'], product_data['code'], bundles)
    end
  end
end