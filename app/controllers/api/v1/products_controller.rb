class Api::V1::ProductsController < ApplicationController
  respond_to :json

  before_action :set_product, only: [:show, :update, :destroy]

  def index
    respond_with Product.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: { product: @product }, status: 201
    else
      render json: { product: @product.errors.full_messages }, status: 422
    end
  end

  def show
    respond_with(@product)
  end

  def update
    if @product.update_attributes(product_params)
      render json: { product: @product }, status: 200
    else
      render json: { product: @product.errors.full_messages }, status: 422
    end
  end

  def destroy
    @product.destroy
    render nothing: true, status: 204
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end