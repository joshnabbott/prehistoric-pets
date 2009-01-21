class Cart::OrdersController < Cart::CartController
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(cart_items_path) }
    end
  end
end