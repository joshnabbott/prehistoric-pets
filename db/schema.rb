# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090817015942) do

  create_table "announcements", :force => true do |t|
    t.string   "title_short"
    t.text     "body_short"
    t.string   "title_long"
    t.text     "body_long"
    t.boolean  "is_featured",         :default => false, :null => false
    t.boolean  "is_active",           :default => false, :null => false
    t.string   "permalink",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_announcement_id"
  end

  add_index "announcements", ["is_active"], :name => "index_announcements_on_is_active"
  add_index "announcements", ["is_featured", "is_active"], :name => "index_announcements_on_is_featured_and_is_active"

  create_table "asset_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asset_categories", ["name"], :name => "index_asset_categories_on_name"

  create_table "asset_categories_assets", :id => false, :force => true do |t|
    t.integer "asset_id"
    t.integer "asset_category_id"
  end

  create_table "asset_resources", :force => true do |t|
    t.integer  "asset_id",                      :null => false
    t.integer  "owner_id",                      :null => false
    t.string   "owner_type",                    :null => false
    t.boolean  "is_active",  :default => false, :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asset_resources", ["asset_id"], :name => "index_asset_resources_on_asset_id"
  add_index "asset_resources", ["owner_id", "owner_type"], :name => "index_asset_resources_on_owner_id_and_owner_type"

  create_table "assets", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.integer  "size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["id", "type"], :name => "index_assets_on_id_and_type"
  add_index "assets", ["type"], :name => "index_assets_on_type"

  create_table "caresheets", :force => true do |t|
    t.string   "name"
    t.string   "scientific_name"
    t.string   "permalink"
    t.text     "body"
    t.boolean  "is_active",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_caresheet_id"
  end

  add_index "caresheets", ["is_active"], :name => "index_caresheets_on_is_active"
  add_index "caresheets", ["permalink"], :name => "index_caresheets_on_permalink", :unique => true

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.boolean  "is_active",                                         :default => false, :null => false
    t.boolean  "is_price_specific",                                 :default => false, :null => false
    t.decimal  "starting_price",      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "ending_price",        :precision => 8, :scale => 2, :default => 0.0
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_category_id"
    t.integer  "old_sub_category_id"
  end

  add_index "categories", ["parent_id"], :name => "index_categories_on_parent_id"
  add_index "categories", ["permalink"], :name => "index_categories_on_permalink", :unique => true

  create_table "crop_definitions", :force => true do |t|
    t.integer  "asset_category_id"
    t.string   "name"
    t.integer  "minimum_width",     :default => 0,     :null => false
    t.integer  "minimum_height",    :default => 0,     :null => false
    t.integer  "x",                 :default => 0,     :null => false
    t.integer  "y",                 :default => 0,     :null => false
    t.boolean  "is_specific",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crop_definitions", ["name", "asset_category_id"], :name => "index_crop_definitions_on_name_and_asset_category_id"

  create_table "crops", :force => true do |t|
    t.integer  "image_id",           :null => false
    t.integer  "crop_definition_id"
    t.integer  "x",                  :null => false
    t.integer  "y",                  :null => false
    t.integer  "width",              :null => false
    t.integer  "height",             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crops", ["crop_definition_id", "image_id"], :name => "index_crops_on_crop_definition_id_and_image_id"

  create_table "line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity",                                 :default => 1,   :null => false
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["order_id", "product_id"], :name => "index_line_items_on_order_id_and_product_id"
  add_index "line_items", ["order_id"], :name => "index_line_items_on_order_id"
  add_index "line_items", ["product_id"], :name => "index_line_items_on_product_id"

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.decimal  "amount",           :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.boolean  "is_success",                                     :default => false, :null => false
    t.boolean  "is_test",                                        :default => false, :null => false
    t.string   "reference_number"
    t.string   "action"
    t.text     "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "order_transactions", ["reference_number"], :name => "index_order_transactions_on_reference_number"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "reference_number"
    t.string   "state",                                          :default => "in_cart", :null => false
    t.integer  "line_items_count",                               :default => 0
    t.decimal  "shipping",         :precision => 8, :scale => 2, :default => 0.0,       :null => false
    t.decimal  "subtotal",         :precision => 8, :scale => 2, :default => 0.0,       :null => false
    t.decimal  "tax",              :precision => 8, :scale => 2, :default => 0.0,       :null => false
    t.decimal  "amount",           :precision => 8, :scale => 2, :default => 0.0,       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["ip_address"], :name => "index_orders_on_ip_address"
  add_index "orders", ["reference_number", "state"], :name => "index_orders_on_reference_number_and_state"
  add_index "orders", ["state"], :name => "index_orders_on_state"
  add_index "orders", ["updated_at", "state"], :name => "index_orders_on_updated_at_and_state"

  create_table "post_o_matic_categories", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "permalink"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_o_matic_categories", ["name"], :name => "index_post_o_matic_categories_on_name", :unique => true
  add_index "post_o_matic_categories", ["permalink"], :name => "index_post_o_matic_categories_on_permalink", :unique => true

  create_table "post_o_matic_postings", :force => true do |t|
    t.integer  "product_id"
    t.integer  "post_o_matic_category_id"
    t.string   "post_to"
    t.integer  "ad_duration"
    t.datetime "expires_at"
    t.datetime "posted_at"
    t.string   "state",                    :default => "scheduled"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_o_matic_postings", ["post_o_matic_category_id"], :name => "index_post_o_matic_postings_on_post_o_matic_category_id"
  add_index "post_o_matic_postings", ["product_id"], :name => "index_post_o_matic_postings_on_product_id"
  add_index "post_o_matic_postings", ["state"], :name => "index_post_o_matic_postings_on_state"

  create_table "products", :force => true do |t|
    t.integer  "caresheet_id"
    t.string   "name"
    t.string   "scientific_name"
    t.string   "permalink"
    t.string   "sku",                  :limit => 10,                                                  :null => false
    t.text     "description"
    t.text     "comments"
    t.decimal  "price",                              :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.boolean  "is_featured",                                                      :default => false, :null => false
    t.boolean  "override",                                                         :default => false, :null => false
    t.boolean  "is_active",                                                        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_product_id"
    t.integer  "shipping_category_id"
  end

  add_index "products", ["is_active", "is_featured"], :name => "index_products_on_is_active_and_is_featured"
  add_index "products", ["is_active"], :name => "index_products_on_is_active"
  add_index "products", ["permalink"], :name => "index_products_on_permalink"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shipping_categories", :force => true do |t|
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shipping_categories", ["name"], :name => "index_shipping_categories_on_name"

  create_table "taxons", :force => true do |t|
    t.integer  "category_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taxons", ["category_id"], :name => "index_taxons_on_category_id"
  add_index "taxons", ["product_id"], :name => "index_taxons_on_product_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
