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
      render json: {product: @product.errors, status: :unprocessable_entity}
    end
  end

  def show
    @product = Product.find(params[:id])
    respond_with(@product.as_json)
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      render json: @product.as_json, status: :ok
    else
      render json: {product: @product.errors, status: :unprocessable_entity}
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    render json: {status: :no_content}
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end