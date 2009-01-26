class CreatePostOMaticPostings < ActiveRecord::Migration
  def self.up
    create_table :post_o_matic_postings do |t|
      t.belongs_to :product
      t.string :post_to, :post_in
      t.string :state, :default => 'scheduled', :nil => false
      t.integer :position
      t.timestamps
    end
    add_index :post_o_matic_postings, :state
  end

  def self.down
    drop_table :post_o_matic_postings
  end
end
