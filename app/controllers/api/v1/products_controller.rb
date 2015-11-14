class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    respond_with Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product.as_json, status: :ok
    else
      render json: {product: @product.errors, status: :no_content}
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end