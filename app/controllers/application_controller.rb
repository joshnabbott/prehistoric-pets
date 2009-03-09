class Error404 < StandardError; end
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :find_order #, :find_items_in_cart
  helper :all # include all helpers, all the time
  rescue_from Error404, :with => :render_404_error

  filter_parameter_logging :password

private
  def find_items_in_cart
    cookies[:items_in_cart] = { :value => "#{@order.product_count}" }
  end

  def find_order
    if session[:order_reference_number].blank?
      @order = Order.create(:ip_address => request.remote_ip)
    else
      @order = Order.find_or_create_by_reference_number_and_state(session[:order_reference_number], 'in_cart')
    end
    session[:order_reference_number] = @order.reference_number
    @order
  end

  def render_404_error
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end
end
