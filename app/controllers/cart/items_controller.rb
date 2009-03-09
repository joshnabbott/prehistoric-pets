class Cart::ItemsController < Cart::CartController
  after_filter :set_items_in_cart, :only => [ :create, :destroy ]

  def index
    respond_to do |format|
      format.html
    end
  end

  def create
    @order.add_to_cart(Product.find(params[:product_id]), :quantity => params[:quantity])

    respond_to do |format|
      format.html { redirect_to(cart_items_path) }
      format.js
    end
  end

  def destroy
    @item = LineItem.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(cart_items_path) }
    end
  end

protected
  def set_items_in_cart
    cookies[:items_in_cart] = @order.product_count
  end
end
