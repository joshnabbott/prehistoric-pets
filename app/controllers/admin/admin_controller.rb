class Admin::AdminController < ApplicationController
  before_filter :login_required
  before_filter :create_instance_variables_from_params

  layout 'admin/admin'
  skip_before_filter :find_order

protected
  def create_instance_variables_from_params
    params.each do |name, value|
      instance_variable_set("@#{$1}", $1.classify.constantize.find_by_id(value)) if name =~ /(.+)_id$/ && !value.blank?
    end
  end
end
