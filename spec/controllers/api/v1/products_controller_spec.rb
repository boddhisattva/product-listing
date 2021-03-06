require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do

  describe '#index' do

    before do
      FactoryGirl.create(:product)

      get :index, format: 'json'
    end

    it "gets a list of all the products" do
      expect(json_response[0]['name']).to eq('Samsung Galaxy Note 2')
    end

    it "returns an OK(200) status code" do
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    context "product details are correctly specified" do

      let(:product_params) { { product: { name: "Macbook air",
                                          description: "A laptop",
                                          price: 70000 } } }

      context "a successful create request" do
        it "increases the number of products by one" do
          expect {post :create, product_params, format: 'json'}.to change(Product, :count).by(1)
        end

        it "returns an OK(201) created code" do
          post :create, product_params, format: 'json'

          expect(response.status).to eq(201)
        end
      end
    end

    context "product details are not correctly specified" do
      context "product name is not specified and price is incorrectly specified" do

        let(:product_params) { { product: { description: "A laptop",
                                            price: "text 123" } } }

        context "an unsuccessful create request" do
          it "does not create a new product" do
            expect {post :create, product_params, format: 'json'}.not_to change(Product, :count)
          end

          it "returns with an appropriate error message" do
            post :create, product_params, format: 'json'

            expect(json_response['product']).to eq(["Name can't be blank",
                                                    "Price is not a number"])
          end

          it "returns an unprocessable entity(422) status code" do
            post :create, product_params, format: 'json'

            expect(response.status).to eq(422)
          end
        end
      end
    end
  end

  describe '#show' do

    let(:product) { FactoryGirl.create(:product) }

    it "should return details of a particular product" do
      get :show, id: product.id, format: 'json'

      expect(json_response['name']).to eq('Samsung Galaxy Note 2')
    end

    it "returns an OK(200) status code" do
      get :show, id: product.id, format: 'json'

      expect(response.status).to eq(200)
    end
  end

  describe '#update' do

    let(:product) { FactoryGirl.create(:product) }

    context "product details are correctly specified" do

      before do
        patch :update, id: product.id,
                       product: {price: 35000},
                       format: 'json'
      end

      context "a successful update request" do
        it "correctly updates the product details" do
          expect(product.reload.price).to eq(35000)
        end

        it "returns an OK(200) status code" do
          expect(response.status).to eq(200)
        end
      end
    end

    context "product details are not correctly specified" do
      context "product description is empty" do

        before do
          patch :update, id: product.id,
                         product: {description: ''},
                         format: 'json'
        end

        context "an unsuccessful update request" do
          it "does not update the product" do
            expect(product.reload.description).not_to be_empty
          end

          it "returns with an appropriate error message" do
            expect(json_response['product']).to eq(["Description can't be blank"])
          end

          it "returns an unprocessable entity(422) status code" do
            expect(response.status).to eq(422)
          end
        end
      end
    end
  end

  describe "#destroy" do

    let!(:product) { FactoryGirl.create(:product) }

    it "should remove the product from the database" do
      expect {delete :destroy, id: product.id, format: 'json'}.to change(Product, :count).by(-1)
    end

    it "returns a no content(204) status code" do
      delete :destroy, id: product.id, format: 'json'

      expect(response.status).to eq(204)
    end
  end

end