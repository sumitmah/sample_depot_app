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
    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    product = params[:product]
    if @product.update_attributes("title" => product[:title])
      redirect_to(product_path)
    else
        render edit_product_path(@product.id)
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path
  end

end
