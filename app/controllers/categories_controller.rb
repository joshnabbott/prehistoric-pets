class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_permalink(params[:categories].last) || raise(ActiveRecord::RecordNotFound, 'Record not found.')
    @products = @category.products.active
  end
end