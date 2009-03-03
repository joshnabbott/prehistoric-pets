class StaticController < ApplicationController
  caches_page :show

  def show
    page_path = params[:path].join('/')
    if File.exists?("#{RAILS_ROOT}/app/views/static/#{page_path}.html.erb")
      render :template => "static/#{page_path}"
    elsif File.exists?("#{RAILS_ROOT}/app/views/static/#{page_path}/index.html.erb")
      render :template => "static/#{page_path}/index"
    else
      raise Error404
    end
  end
end