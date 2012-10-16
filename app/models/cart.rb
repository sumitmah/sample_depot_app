class Cart
  include Mongoid::Document

  has_many :line_items, dependent: :destroy

  def add_product(product)
    p line_items
    current_item = find_by_product_id(line_items, product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  private

  def find_by_product_id line_items, product_id
    line_items.each {|item|
      return item if item.product.id == product_id
    }
    nil
  end

end
