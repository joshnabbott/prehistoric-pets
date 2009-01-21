class Error404 < StandardError; end
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  before_filter :find_order
  helper :all # include all helpers, all the time
  rescue_from Error404, :with => :render_404_error

  protect_from_forgery :secret => '5547deee5dffa6aeb3678df88bb8aed5'

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  filter_parameter_logging :password
private
  def find_order
    if session[:order_id].blank?
      @order = Order.create(:ip_address => request.remote_ip)
    else
      @order = Order.find_or_create_by_id(session[:order_id])
    end
    session[:order_id] = @order.id
    @order
  end

  def render_404_error
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end
end
