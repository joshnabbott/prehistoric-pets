class HomeController < ApplicationController
  def index
    @caresheets             = Caresheet.active
    @featured_announcements = Announcement.featured.active.find(:all, :order => 'created_at desc', :limit => 2)
    @featured_product       = Product.featured.active.find(:first, :order => 'RANDOM()')

    respond_to do |format|
      format.html # index.html.erb
      format.js { render 'featured_announcement', :collection => @featured_announcements }
    end
  end
end
