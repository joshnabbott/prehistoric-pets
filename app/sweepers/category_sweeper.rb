class CategorySweeper < ActionController::Caching::Sweeper
  observe Category

  def after_save(category)
    expire_cache_for(category)
  end

  def after_destroy(category)
    expire_cache_for(category)
  end

protected
  def expire_cache_for(category)
    # Since categories build the navigation, and there's navigation on every page...
    # You guessed it, all pages have to be expired. That includes the /products directory, /announcements directory
    # /browse directory and /about.html and /contact-us.html
    Category.benchmark "Expired directory: #{ActionController::Base.page_cache_directory}/announcements" do
      FileUtils.rm_rf("#{ActionController::Base.page_cache_directory}/announcements")
    end

    Category.benchmark "Expired directory: #{ActionController::Base.page_cache_directory}/browse" do
      FileUtils.rm_rf("#{ActionController::Base.page_cache_directory}/browse")
    end

    Category.benchmark "Expired directory: #{ActionController::Base.page_cache_directory}/products" do
      FileUtils.rm_rf("#{ActionController::Base.page_cache_directory}/products")
    end

    Category.benchmark "Expired static pages." do
      FileUtils.rm_rf("#{ActionController::Base.page_cache_directory}/about.html")
      FileUtils.rm_rf("#{ActionController::Base.page_cache_directory}/contact-us.html")
    end
  end
end