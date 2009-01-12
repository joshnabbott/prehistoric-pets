class CategoriesController < ApplicationController
  def index
    @categories = Category.find(:all)
  end

  def show
    @category = Category.find(params[:id])
  end
end
