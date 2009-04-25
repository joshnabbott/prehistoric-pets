class ProductsController < ApplicationController
  # caches_page :show

  def show
    @product = Product.find(params[:id])
    raise Error404 unless @product.is_active
    respond_to do |format|
      format.jpg # show.jpg.flexi
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end
end