class LineItem
  include Mongoid::Document
  belongs_to :product
  belongs_to :cart

  field :quantity, type: Integer, default: 1

  def total_price
    product.price * quantity
  end
end
