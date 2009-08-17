class AddShippingCategoryIdToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :shipping_category_id, :integer
    shipping_category = ShippingCategory.find_or_create_by_name('Standard')
    shipping_category.update_attribute(:price, 55)
    Product.update_all("`products`.`shipping_category_id` = #{shipping_category.id}", '`products`.`shipping_category_id` IS NULL')
  end

  def self.down
    remove_column :products, :shipping_category_id
  end
end
