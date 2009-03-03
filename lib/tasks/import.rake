namespace :db do
  namespace :import do
    desc 'This will import the category data from the old site tables to this one.'
    task :categories => :environment do
      require 'FasterCSV'
      Category.destroy_all
      csv              = FasterCSV.read("#{RAILS_ROOT}/assets/PrehistoricPets/tblCategories.txt")
      fields           = csv.shift
      attributes_array = csv.collect { |record| Hash[*(0..(fields.length - 1)).collect { |index| [fields[index],record[index].to_s] }.flatten ] }
      categories_array = attributes_array.inject([]) do |array, attribute_hash|
        attributes = {
                      :old_category_id => attribute_hash['id'],
                      :name => attribute_hash['name'],
                      :description => attribute_hash['description'],
                      :is_active => attribute_hash['is_active'],
                      :is_price_specific => attribute_hash['is_price_specific'].blank? ? false : true,
                      :starting_price => attribute_hash['starting_price'],
                      :ending_price => attribute_hash['ending_price']
                     }
        array << Category.new(attributes)
        array
      end
      categories_array.map(&:save!)
      puts "#{Category.count} categories created."
    end

    desc 'This will import the sub-category data from the old site tables to this one.'
    task :sub_categories => :environment do
      require 'FasterCSV'
      Category.destroy_all('parent_id IS NOT NULL')
      csv              = FasterCSV.read("#{RAILS_ROOT}/assets/PrehistoricPets/tblSubCategories.txt")
      fields           = csv.shift
      attributes_array = csv.collect { |record| Hash[*(0..(fields.length - 1)).collect { |index| [fields[index],record[index].to_s] }.flatten ] }
      categories_array = attributes_array.inject([]) do |array, attribute_hash|
        attributes = {
                      :old_sub_category_id => attribute_hash['id'],
                      :parent => Category.find_by_old_category_id(attribute_hash['parent_id']),
                      :name => attribute_hash['name'],
                      :description => attribute_hash['description'],
                      :is_active => attribute_hash['is_active'],
                      :is_price_specific => attribute_hash['is_price_specific'].blank? ? false : true,
                      :starting_price => attribute_hash['starting_price'],
                      :ending_price => attribute_hash['ending_price']
                     }
        array << Category.new(attributes)
        array
      end
      categories_array.map(&:save!)
      puts "#{Category.count(:conditions => 'parent_id IS NOT NULL')} categories created."
    end

    desc 'This will import the product data from the old site tables to this one.'
    task :products => :environment do
      require 'FasterCSV'

      Product.destroy_all
      csv              = FasterCSV.read("#{RAILS_ROOT}/assets/PrehistoricPets/tblInventory.txt")
      fields           = csv.shift
      attributes_array = csv.collect { |record| Hash[*(0..(fields.length - 1)).collect { |index| [fields[index],record[index].to_s] }.flatten ] }
      products_array = attributes_array.inject([]) do |array, attribute_hash|
        attributes = {
                      :old_product_id => attribute_hash['id'],
                      :categories => [Category.find_by_old_category_id(attribute_hash['category_id']), Category.find_by_old_sub_category_id(attribute_hash['sub_category_id'])].compact,
                      :name => attribute_hash['name'],
                      :description => attribute_hash['description'],
                      :scientific_name => attribute_hash['scientific_name'],
                      :price => attribute_hash['price'].gsub('$',''),
                      :override => attribute_hash['override'],
                      :comments => attribute_hash['comments'],
                      :caresheet => Caresheet.find_by_old_caresheet_id(attribute_hash['care_sheet_id']),
                      :is_active => attribute_hash['is_active'],
                      :is_featured => attribute_hash['is_featured'],
                      :sku => attribute_hash['sku']
                     }
        array << Product.new(attributes)
        array
      end
      # Too many errors in the data to validate.
      products_array.map(&:save)
      puts "#{Product.count} products created."
    end

    desc 'This will import the product images from the old site using FlexImage\'s image_file_url attribute.'
    task :product_images => :environment do
      require 'FasterCSV'
      require 'httparty'

      FileUtils.rm_rf("#{RAILS_ROOT}/images/uploads")

      csv              = FasterCSV.read("#{RAILS_ROOT}/assets/PrehistoricPets/tblInventory.txt")
      fields           = csv.shift
      attributes_array = csv.collect { |record| Hash[*(0..(fields.length - 1)).collect { |index| [fields[index],record[index].to_s] }.flatten ] }
      products_array = attributes_array.inject([]) do |array, attribute_hash|
        product = Product.find_by_old_product_id(attribute_hash['id'])
        if product
          begin
            product.image_file_url = "http://prehistoricpets.com/images/animals/#{attribute_hash['image_path']}.jpg"
          rescue Exception => e
            puts e.inspect
          end
          array << product
        end
        array
      end
      products_array.map(&:save)
      puts 'Done.'
    end
  end
end