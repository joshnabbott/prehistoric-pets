class ImageSweeper < ActionController::Caching::Sweeper
  observe Image

  def after_save(image)
    expire_cache(image)
  end

  def after_destroy(image)
    expire_cache(image)
  end

  def expire_cache(image)
    Image.benchmark "Expired directory: #{ActionController::Base.page_cache_directory}/images/#{image.to_param}" do
      FileUtils.rm_rf("#{ActionController::Base.page_cache_directory}/images/#{image.to_param}")
    end
  end
end