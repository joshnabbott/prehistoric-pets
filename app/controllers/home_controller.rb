class HomeController < ApplicationController
  def index
    @featured_announcements = Announcement.featured.active(:limit => 2)
    @featured_products      = Product.featured.active
  end
end
