class AddLegacyPrimaryKeyColsToTables < ActiveRecord::Migration
  def self.up
    add_column :categories, :old_category_id, :integer
    add_column :categories, :old_sub_category_id, :integer
    add_column :products, :old_product_id, :integer
    add_column :caresheets, :old_caresheet_id, :integer
    add_column :announcements, :old_announcement_id, :integer
  end

  def self.down
    remove_column :categories, :old_category_id
    remove_column :categories, :old_sub_category_id
    remove_column :products, :old_product_id
    remove_column :caresheets, :old_caresheet_id
    remove_column :announcements, :old_announcement_id
  end
end
