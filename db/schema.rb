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

ActiveRecord::Schema.define(:version => 20090119025548) do

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
