class Admin::AdminController < ApplicationController
  before_filter :login_required
  layout 'admin/admin'
end
