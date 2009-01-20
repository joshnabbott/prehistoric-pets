class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_permalink(params[:categories].last)
    raise Error404 unless @category
    @products = @category.products.active
  end
end