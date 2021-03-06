require 'spec_helper'

describe ProductsController do
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

  describe "GET 'new'" do
    it "should return HTTP success" do
      get 'new'
      response.should be_success
    end

    it "should allow to create new product" do
      get 'new'
      assigns(:product).should_not be_nil
      response.should render_template :new
    end
  end

  describe "POST 'create'" do
    context "with valid attributes" do
      it "creates a new product" do
        expect{
          post :create, product: { title: "Hello", description: "description", image_url: "image_url.gif", price: "11.0" }
        }.to change(Product,:count).by(1)
      end

      it "redirects to the new product" do
        post :create, product: { title: "Hello", description: "description", image_url: "image_url.gif", price: "11.0" }
        response.should be_redirect
      end
    end

    context "with invalid attributes" do
      it "does not save the new product" do
        expect{
          post :create, :title => ""
        }.to_not change(Product,:count)
      end

      it "re-renders the new method" do
        post :create, :title => ""
        response.should render_template :new
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested product to @product" do
      product = FactoryGirl.create(:product)
      get :show, id: product.id
      assigns(:product).should eq(product)
    end

    it "renders the #show view" do
      product = FactoryGirl.create(:product)
      get :show, id: product.id
      response.should render_template :show
    end
  end

  describe "delete #destroy" do
    context "with valid attributes" do
      it "should delete a product" do
        product = FactoryGirl.create(:product)
        expect {
          delete 'destroy', id: product.id
        }.to change(Product, :count).by(-1)
      end

      it "redirects to the index" do
        product = FactoryGirl.create(:product)
        delete 'destroy', id: product.id
        response.should be_redirect
      end
    end
  end

  describe "GET #edit" do
    context "with valid attributes" do
      it "should edit a product" do
        product = FactoryGirl.create(:product)
        get 'edit', id: product.id
        assigns(:product).should_not be_nil
        response.should render_template :edit
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "should update the title of product" do
        product = FactoryGirl.create(:product)
        put :update, id: product.id, product: { title: "product12", price: "10.12", image_url: "image_url.gif", description: "description" }

        response.should be_redirect

        product.reload

        product.title.should eq "product12"
        product.description.should eq "description"
        product.image_url.should eq "image_url.gif"
        product.price.should eq 10.12
      end
    end
  end
end
