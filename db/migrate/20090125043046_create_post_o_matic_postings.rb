class CreatePostOMaticPostings < ActiveRecord::Migration
  def self.up
    create_table :post_o_matic_postings do |t|
      t.belongs_to :product, :post_o_matic_category
      t.string :post_to
      t.integer :ad_duration
      t.datetime :expires_at, :posted_at
      t.string :state, :default => 'scheduled', :nil => false
      t.integer :position
      t.timestamps
    end
    add_index :post_o_matic_postings, :state
    add_index :post_o_matic_postings, :product_id
    add_index :post_o_matic_postings, :post_o_matic_category_id
  end

  def self.down
    drop_table :post_o_matic_postings
  end
end
