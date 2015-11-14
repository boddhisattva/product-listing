require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  describe '#index' do
    it "gets a list of all the products" do
      FactoryGirl.create(:product)

      get :index, format: 'json'

      expect(json_response[0]['name']).to eq('Samsung Galaxy Note 2')
    end

    it "returns an OK(200) status code" do
      FactoryGirl.create(:product)

      get :index, format: 'json'

      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    context "product details are correctly specified" do
      context "a successful create request" do
        it "increases the number of products by one" do
          product_params = {product: {name: "Macbook air", description: "A laptop", price: 70000}}

          expect {post :create, product_params, format: 'json'}.to change(Product, :count).by(1)
        end

        it "returns an OK(200) status code" do
          product_params = {product: {name: "Macbook air", description: "A laptop", price: 70000}}

          post :create, product_params, format: 'json'

          expect(json_response["status"]).to eq(200)
        end
      end
    end

    context "product details are not correctly specified" do
      context "product name is not passed" do
        context "an unsuccessful create request" do
          it "does not create a new product" do
            product_params = {product: {description: "A laptop", price: 70000}}

            expect {post :create, product_params, format: 'json'}.not_to change(Product, :count)
          end

          it "returns an unprocessable entity(422) status code" do
            product_params = {product: {description: "A laptop", price: 70000}}

            post :create, product_params, format: 'json'

            expect(json_response["status"]).to eq(422)
          end
        end
      end
    end
  end

  describe '#update' do
    context "product details are correctly specified" do
      context "a successful update request" do
        it "correctly updates the product details" do
          product = FactoryGirl.create(:product)

          patch :update, id: product.id,
                         product: {price: 35000},
                         format: 'json'

          expect(product.reload.price).to eq(35000)
        end

        it "returns an OK(200) status code" do
          product = FactoryGirl.create(:product)

          patch :update, id: product.id,
                         product: {price: 35000},
                         format: 'json'

          expect(json_response["status"]).to eq(200)
        end
      end
    end

    context "product details are not correctly specified" do
      context "product description is empty" do
        context "an unsuccessful update request" do
          it "does not update the product" do
            product = FactoryGirl.create(:product)

            patch :update, id: product.id,
                           product: {description: ''},
                           format: 'json'

            expect(product.reload.description).not_to be_empty
          end

          it "returns an unprocessable entity(422) status code" do
            product = FactoryGirl.create(:product)

            patch :update, id: product.id,
                           product: {description: ''},
                           format: 'json'

            expect(json_response["status"]).to eq(422)
          end

        end
      end
    end
  end

end