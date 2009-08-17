class StaticController < ApplicationController
  STATIC_PATH = File.join(RAILS_ROOT, 'app', 'views', 'static')
  caches_page :show

  def show
    page_path = params[:path].join('/')
    if File.exists?(File.join(STATIC_PATH, "#{page_path}.html.erb"))
      render :template => "static/#{page_path}"
    elsif File.exists?(File.join(STATIC_PATH, page_path, 'index.html.erb'))
      render :template => "static/#{page_path}/index.html.erb"
    else
      raise Error404
    end
  end
end