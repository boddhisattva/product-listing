class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    respond_with Product.all
  end
end