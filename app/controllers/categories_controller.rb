class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_permalink(params[:categories].last)
    raise Error404 unless @category
    # if @category.is_price_specific
    #   @product = Product.by_price(@category.starting_price,@category.ending_price)
    # else
      @products = @category.products.active
    # end
  end
end