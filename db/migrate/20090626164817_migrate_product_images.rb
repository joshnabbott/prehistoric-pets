class MigrateProductImages < ActiveRecord::Migration
  def self.up
    say_with_time "Migrating images to new schema." do
      ########################################
      # Kill existing asset categories
      AssetCategory.destroy_all

      ########################################
      # Create the asset categories and crop definitions
      returning @product_images_asset_category = AssetCategory.new(:name => 'Product Images') do |asset_category|
        asset_category.crop_definitions.build(:name => 'Thumbnail', :minimum_width => 239, :minimum_height => 239, :x => 0, :y => 0)
        asset_category.crop_definitions.build(:name => 'Main', :minimum_width => 400, :minimum_height => 239, :x => 0, :y => 0)
        asset_category.save!
      end

      ########################################
      # Move image from product to an image record
      products = Product.all
      products.each do |product|
        image            = product.images.build(:asset_category_ids => [@product_images_asset_category.id], :name => product.name)
        image.image_file = File.new(product.file_path)
        product.delete_image_file
        puts product.save!
      end

      ########################################
      # Update the crops to be all the same width and height as the images
      crops = Crop.all(:include => :image)
      crops.each do |crop|
        next if crop.image.nil?
        crop.width  = crop.image.image_width
        crop.height = crop.image.image_height
        crop.save!
      end
    end
  end

  def self.down
    products = Product.all
    products.each do |product|
      image              = product.images.default
      product.image_file = File.new(image.file_path)
      image.delete_image_file
      puts product.save!
      puts product.save!
    end

    AssetCategory.destroy_all
  end
end
