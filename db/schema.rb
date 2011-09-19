# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110604100212) do

  create_table "bonus_upgrade_details", :force => true do |t|
    t.string   "objective_name"
    t.integer  "bonus_reward_score"
    t.decimal  "bonus_reward_price", :precision => 10, :scale => 0
    t.integer  "upgrade_count"
    t.integer  "upgrade_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "is_show",    :default => 1
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                                 :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 25
    t.string   "guid",              :limit => 10
    t.integer  "locale",            :limit => 1,  :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "fk_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "discount_details", :force => true do |t|
    t.decimal  "discount_rate", :precision => 10, :scale => 0, :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",                                  :default => 1
    t.integer  "order_id"
    t.decimal  "price",      :precision => 10, :scale => 2
  end

  create_table "order_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "postcode"
    t.string   "telephone"
    t.string   "pay_type"
    t.string   "taobao_url"
    t.string   "taobao_invoice_number"
    t.decimal  "total_price",           :precision => 10, :scale => 2
    t.decimal  "discount_price",        :precision => 10, :scale => 2
    t.string   "invoice_number"
    t.integer  "order_status_id"
    t.datetime "shipping_date"
    t.datetime "payment_date"
    t.datetime "close_date"
    t.text     "cancel_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "shipping_price",        :precision => 10, :scale => 2
    t.decimal  "pay_price",             :precision => 10, :scale => 2
    t.integer  "package_count"
    t.string   "wangwang_number"
    t.string   "province"
    t.text     "memo"
    t.string   "shipping_number"
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.integer  "category_id"
    t.text     "description"
    t.decimal  "price",              :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "intro"
    t.decimal  "weight",             :precision => 6,  :scale => 2, :default => 0.0
    t.decimal  "cost",               :precision => 10, :scale => 2
    t.integer  "status",                                            :default => 0
    t.string   "abb_name"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "postcode"
    t.string   "telephone"
    t.integer  "discount_rank",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "sex"
    t.integer  "bonus_score",     :default => 0
    t.string   "wangwang_number"
    t.string   "province"
    t.integer  "buy_count",       :default => 0
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serial_numbers", :force => true do |t|
    t.string   "serial_number_name"
    t.integer  "current_max_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_fees", :force => true do |t|
    t.decimal  "weight",     :precision => 10, :scale => 0
    t.decimal  "price",      :precision => 8,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                               :default => 3
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
