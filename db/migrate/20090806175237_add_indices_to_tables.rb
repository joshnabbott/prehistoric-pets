class AddIndicesToTables < ActiveRecord::Migration
  def self.up
    remove_index :orders, :reference_number rescue nil
    add_index :announcements, :is_active rescue nil
    add_index :announcements, [:is_featured, :is_active] rescue nil
    add_index :products, :is_active rescue nil
    add_index :products, [:is_active, :is_featured] rescue nil
    add_index :assets, :type rescue nil
    add_index :assets, [:id, :type] rescue nil
    add_index :caresheets, :is_active rescue nil
    add_index :categories, :parent_id rescue nil
    add_index :taxons, :category_id rescue nil
    add_index :taxons, :product_id rescue nil
  end

  def self.down
    add_index :orders, :reference_number rescue nil
    remove_index :announcements, :is_active rescue nil
    remove_index :announcements, [:is_featured, :is_active] rescue nil
    remove_index :products, :is_active rescue nil
    remove_index :products, [:is_active, :is_featured] rescue nil
    remove_index :assets, :type rescue nil
    remove_index :assets, [:id, :type] rescue nil
    remove_index :caresheets, :is_active rescue nil
    remove_index :categories, :parent_id rescue nil
    remove_index :taxons, :category_id rescue nil
    remove_index :taxons, :product_id rescue nil
  end
end
