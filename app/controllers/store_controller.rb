class StoreController < ApplicationController
  def index
    @products = Product.all.sort(title: 1)
    @cart = current_cart
  end
end
