class AddPostAtToPostOMaticCategories < ActiveRecord::Migration
  def self.up
    add_column :post_o_matic_categories, :post_at, :string
  end

  def self.down
    remove_column :post_o_matic_categories, :post_at
  end
end
