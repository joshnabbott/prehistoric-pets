class CategoriesController < ApplicationController
  caches_page :show

  def show
    @category = Category.find_by_permalink(params[:categories].last)
    raise Error404 unless @category
    if (@category.is_price_specific && (!@category.starting_price.blank? && !@category.ending_price.blank?))
      @products = Product.by_price_range(@category.starting_price, @category.ending_price)
    else
      @products = @category.products.active
    end
  end
end