class Admin::AdminController < ApplicationController
  include AuthenticatedSystem
  before_filter :login_required
end
