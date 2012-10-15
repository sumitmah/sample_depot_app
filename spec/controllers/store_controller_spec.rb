require 'spec_helper'

describe StoreController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "should list some products" do
      FactoryGirl.create(:product)
      get 'index'
      assigns(:products).should_not be_nil
    end
  end

end
