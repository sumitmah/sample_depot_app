require 'spec_helper'

describe "Products" do
  describe "GET /products" do
    it "should display some products" do
      product = Product.create(title: "Nokia 3110c", description: "Nokia 3110 classic", image_url: "mystring.gif", price: "10.0")

      visit products_path

      within "#product_#{product.id}" do
        page.should have_content "Nokia 3110c"
        page.should have_content "Nokia 3110 classic"
      end
    end
  end

  describe "GET #show" do
    it "should display product information" do
      product = FactoryGirl.create(:product)
      visit products_path

      within "#product_#{product.id}" do
        click_link "View"
      end

      within 'h1' do
        page.should have_content "MyString"
      end

      page.should have_content "MyText"
      page.should have_content "9.99"
      page.should have_xpath "//img[@src='MyString.gif']"
    end
  end

  describe "Manage products" do
    context "With valid attributes" do
      it "Adds a new product and displays the results" do
        image_url = "http://bks0.books.google.co.in/books?id=aRDZXwAACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE70msGmy6J5M4lQksYM2qp0CX28kvIwdM_S4Jk7fdOcplaWusoI4bDQ9csFBJVPpWZvHfJHdT6y-hUSFdRrHf0LysrcbP0vuXG-2lN_QDR0O16FMFvrrQmWV_LwgDUmJF-Y0zBas"
        visit products_path
        expect {
          click_link 'New Product'
          fill_in 'product_title', with: "My First Book"
          fill_in 'product_description', with: "description"
          fill_in 'product_price', with: "12"
          fill_in 'product_image_url', with: image_url
          click_button "Create Product"
        }.to change(Product, :count).by(1)

        within 'h1' do
          page.should have_content "My First Book"
        end

        within "#product_details" do
          page.should have_content "description"
          page.should have_content "12"
          page.should have_xpath "//img[@src='http://bks0.books.google.co.in/books?id=aRDZXwAACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE70msGmy6J5M4lQksYM2qp0CX28kvIwdM_S4Jk7fdOcplaWusoI4bDQ9csFBJVPpWZvHfJHdT6y-hUSFdRrHf0LysrcbP0vuXG-2lN_QDR0O16FMFvrrQmWV_LwgDUmJF-Y0zBas']"
        end
      end

      it "Deletes a product" do
        product = FactoryGirl.create(:product, title: "Product1")
        visit products_path
        expect {
          within "#product_#{product.id}" do
            click_link 'Destroy'
          end
        }.to change(Product, :count).by(-1)
        page.should have_content "Products"
        page.should_not have_content "Product1"
      end

      it "should change the attributes of the product" do
        product = FactoryGirl.create(:product)
        visit products_path

        within "#product_#{product.id}" do
          click_link 'Edit'
        end

        fill_in 'product_title', with: "My First Book"
        fill_in 'product_description', with: "description"
        fill_in 'product_price', with: "12"
        fill_in 'product_image_url', with: "image_url"

        click_button "Save Product"

        page.should have_content "My First Book"
        page.should have_content "description"
        page.should have_content "12"
        page.should have_xpath "//img[@src='image_url']"

        page.should_not have_content "MyString"
        page.should_not have_content "MyText"
        page.should_not have_content "9.99"
        page.should_not have_xpath "//img[@src='MyString']"
      end
    end

    context "With invalid attributes" do
      it "Should not add product without title" do
        visit products_path
        expect {
          click_link 'New Product'
          fill_in 'product_title', with: ""
          click_button "Create Product"
        }.to change(Product, :count).by(0)
      end
    end
  end
end
