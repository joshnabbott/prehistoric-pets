class CreatePostOMaticCategories < ActiveRecord::Migration
  def self.up
    create_table :post_o_matic_categories do |t|
      t.string :name, :url, :permalink
      t.integer :position
      t.timestamps
    end
    add_index :post_o_matic_categories, :name, :unique => true
    add_index :post_o_matic_categories, :permalink, :unique => true

    # These are the default starting kingsnake.com categories
    PostOMaticCategory.create(:name => 'Adoptions', :url => 'http://market.kingsnake.com/list.php?cat=10')
    PostOMaticCategory.create(:name => 'Ball Pythons', :url => 'http://market.kingsnake.com/list.php?cat=32')
    PostOMaticCategory.create(:name => 'Pythons', :url => 'http://market.kingsnake.com/list.php?cat=7')
    PostOMaticCategory.create(:name => 'Tree boas', :url => 'http://market.kingsnake.com/list.php?cat=33')
    PostOMaticCategory.create(:name => 'Boa constrictors', :url => 'http://market.kingsnake.com/list.php?cat=8')
    PostOMaticCategory.create(:name => 'Other boas', :url => 'http://market.kingsnake.com/list.php?cat=62')
    PostOMaticCategory.create(:name => 'Rose, rubber, and sand boas', :url => 'http://market.kingsnake.com/list.php?cat=61')
    PostOMaticCategory.create(:name => 'New world rat snakes', :url => 'http://market.kingsnake.com/list.php?cat=60')
    PostOMaticCategory.create(:name => 'Old world rat snakes', :url => 'http://market.kingsnake.com/list.php?cat=64')
    PostOMaticCategory.create(:name => 'Corn snakes', :url => 'http://market.kingsnake.com/list.php?cat=65')
    PostOMaticCategory.create(:name => 'Gray-banded kingsnakes', :url => 'http://market.kingsnake.com/list.php?cat=29')
    PostOMaticCategory.create(:name => 'Other kings and milksnakes', :url => 'http://market.kingsnake.com/list.php?cat=59')
    PostOMaticCategory.create(:name => 'Other snakes', :url => 'http://market.kingsnake.com/list.php?cat=6')
    PostOMaticCategory.create(:name => 'Venomous', :url => 'http://market.kingsnake.com/list.php?cat=40')
  end

  def self.down
    drop_table :post_o_matic_categories
  end
end
