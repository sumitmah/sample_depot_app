require 'spec_helper'

describe "Product" do
  it "should have valid attributes" do
    product = Product.new
    product.invalid?.should be_true
    product.errors[:title].any?.should be_true
    product.errors[:description].any?.should be_true
    product.errors[:price].any?.should be_true
    product.errors[:image_url].any?.should be_true
  end
end
