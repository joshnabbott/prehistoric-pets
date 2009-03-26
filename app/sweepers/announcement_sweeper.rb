class AnnouncementSweeper < ActionController::Caching::Sweeper
  observe Announcement

  def after_save(announcement)
    expire_cache_for(announcement)
  end

  def after_destroy(announcement)
    expire_cache_for(announcement)
  end

protected
  def expire_cache_for(announcement)
    # Expire the page
    expire_page(announcement_path(announcement))

    # Expire the raw image
    expire_page(announcement_path(announcement, :jpg))

    # Expire the various image crops. The way I've set up the routes it will cache images
    # in a directory structure like this:
    # announcements/1-some-announcement-name(using .to_param)/100x100.jpg(the :size option)
    #
    # P.S.: Rails should have a way to expire a directory.
    Announcement.benchmark "Expired directory: #{ActionController::Base.page_cache_directory}/announcements/#{announcement.to_param}" do
      FileUtils.rm_rf("#{ActionController::Base.page_cache_directory}/announcements/#{announcement.to_param}")
    end
  end
end