class AnnouncementsController < ApplicationController
  def index
    @announcements = Announcement.active.find(:all, :order => 'created_at desc')
  end

  def show
    @announcement = Announcement.find(params[:id])
    raise Error404 unless @announcement.is_active
  end
end
