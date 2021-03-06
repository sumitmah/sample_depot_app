class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_cart
    Cart.find(session[:cart_id] || 0)
  rescue Mongoid::Errors::DocumentNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
end
