class HomeController < ApplicationController
  def index
    @featured_announcements = Announcement.featured.active.paginate(:per_page => 1, :page => params[:page], :order => 'created_at desc')
    @featured_products      = Product.featured.active

    respond_to do |format|
      # format.html do 
      #   render :partial => 'featured_announcement', :collection => @featured_announcements if request.xhr? 
      # end
      format.html # index.html.erb
      format.js { render :partial => 'featured_announcement', :collection => @featured_announcements }
    end
  end
end
