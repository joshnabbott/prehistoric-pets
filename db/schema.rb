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

ActiveRecord::Schema.define(:version => 20090127034929) do

  create_table "announcements", :force => true do |t|
    t.string   "title_short"
    t.text     "body_short"
    t.string   "title_long"
    t.text     "body_long"
    t.boolean  "is_featured", :default => false, :null => false
    t.boolean  "is_active",   :default => false, :null => false
    t.string   "permalink",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "caresheets", :force => true do |t|
    t.string   "name"
    t.string   "scientific_name"
    t.string   "permalink"
    t.text     "body"
    t.boolean  "is_active",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "caresheets", ["permalink"], :name => "index_caresheets_on_permalink", :unique => true

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "permalink"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["permalink"], :name => "index_categories_on_permalink", :unique => true

  create_table "images", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type",                     :null => false
    t.text     "description"
    t.boolean  "is_active",   :default => false, :null => false
    t.boolean  "is_default",  :default => false, :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  add_index "orders", ["reference_number"], :name => "index_orders_on_reference_number", :unique => true
  add_index "orders", ["state"], :name => "index_orders_on_state"

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
    t.integer  "category_id"
    t.integer  "caresheet_id"
    t.string   "name"
    t.string   "scientific_name"
    t.string   "permalink"
    t.string   "sku",             :limit => 10,                                                  :null => false
    t.text     "description"
    t.text     "comments"
    t.decimal  "price",                         :precision => 8, :scale => 2, :default => 0.0,   :null => false
    t.boolean  "is_featured",                                                 :default => false, :null => false
    t.boolean  "override",                                                    :default => false, :null => false
    t.boolean  "is_active",                                                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["permalink"], :name => "index_products_on_permalink", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

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
