require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "should display some products" do
      @product = Product.create :title => 'Nokia 3110c'

      visit products_path

      page.should have_content 'Nokia 3110c'
    end
  end
end
