class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new({:title => params[:title]})
    if product.save
      redirect_to :action => :show, :id => product.id
    else
      render :action => 'new'
    end
  end

  def edit

  end

  def show
    @product = Product.find(params[:id])
  end

  def update

  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path
  end

end
