class Cart::CartController < ApplicationController
  def checkout
    if @order.line_items.empty?
      flash[:notice] = "You can't checkout with nothing in your cart."
      redirect_to(root_path)
    end
    @order.checkout!
    respond_to do |format|
      format.js  { render :layout => false }
      format.html
    end
  end
end