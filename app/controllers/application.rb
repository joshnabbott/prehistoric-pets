class Error404 < StandardError; end
class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  rescue_from Error404, :with => :render_404_error

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5547deee5dffa6aeb3678df88bb8aed5'

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  filter_parameter_logging :password
private
  def render_404_error
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
  end
end
