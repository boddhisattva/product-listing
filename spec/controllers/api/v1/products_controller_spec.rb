require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  describe '#create' do
    context "product details that are correctly specified" do
      context "a successful create request" do
        it "increases the number of products by one" do
          product_params = {product: {name: "Macbook air", description: "A laptop", price: 70000}}

          expect {post :create, product_params, format: 'json'}.to change(Product, :count).by(1)
        end

        it "returns an OK(200) status code" do
          product_params = {product: {name: "Macbook air", description: "A laptop", price: 70000}}

          post :create, product_params, format: 'json'

          expect(json["status"]).to eq(200)
        end
      end
    end

    context "product details are not correctly specified" do
      context "product name is not passed" do
        context "an unsuccessful create request" do
          it "returns an unprocessable entity(422) status code" do
            product_params = {product: {description: "A laptop", price: 70000}}

            post :create, product_params, format: 'json'

            expect(json["status"]).to eq(422)
          end
        end
      end
    end
  end
end