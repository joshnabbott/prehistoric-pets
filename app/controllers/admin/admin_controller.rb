class Admin::AdminController < ApplicationController
  before_filter :login_required
  layout 'admin/admin'
  skip_before_filter :find_order
end
