class ProductSweeper < ActionController::Caching::Sweeper
  observe Product

  def after_save(product)
    expire_cache_for(product)
  end

  def after_destroy(product)
    expire_cache_for(product)
  end

protected
  def expire_cache_for(product)
    # Expire the product detail page
    expire_page(product_path(product))

    # Expire the various product image crops. The way I've set up the routes it will cache product images
    # in a directory structure like this:
    # products/1-some-product-name(using .to_param)/100x100.jpg(the :size option)
    #
    # P.S.: Rails should have a way to expire a directory.
    Product.benchmark "Expired directory: #{RAILS_ROOT}/public/products/#{product.to_param}" do
      FileUtils.rm_rf("#{RAILS_ROOT}/public/products/#{product.to_param}")
    end

    # Expire the category page(s) this product is in
    product.categories.each do |category|
      expire_page(category_path(category.path))
    end
  end
end