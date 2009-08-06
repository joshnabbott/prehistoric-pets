class AddIndexOnOrdersUpdatedAtAndState < ActiveRecord::Migration
  def self.up
    add_index :orders, [:updated_at, :state] rescue nil
  end

  def self.down
    remove_index :orders, [:updated_at, :state] rescue nil
  end
end
