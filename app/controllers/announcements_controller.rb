class AnnouncementsController < ApplicationController
  def show
    @announcement = Announcement.find(params[:id])
    raise Error404 unless @announcement.is_active
  end
end
