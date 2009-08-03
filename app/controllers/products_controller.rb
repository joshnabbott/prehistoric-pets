class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    raise Error404 unless @product.is_active
    respond_to do |format|
      format.html # show.html.erb
      format.jpg # show.jpg.flexi
      format.xml  { render :xml => @product }
    end
  end
end