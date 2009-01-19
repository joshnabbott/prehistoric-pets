class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    raise Error404 unless @product.is_active
    respond_to do |format|
      format.jpg # show.jpg.flexi
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  def category_thumbnail
    @product = Product.find(params[:id])
    render :inline => "@product.operate { |p| p.resize '160x160' }", :type => :flexi
  end

  def product_thumbnail
    @product = Product.find(params[:id])
    render :inline => "@product.operate { |p| p.resize '400x239' }", :type => :flexi
  end
end
