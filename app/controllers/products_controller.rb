class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    raise Error404 unless @product.is_active
  end
end
