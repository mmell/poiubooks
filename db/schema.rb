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

ActiveRecord::Schema.define(:version => 20100713165651) do

  create_table "books", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "title",       :null => false
    t.integer  "category_id", :null => false
    t.string   "reward"
    t.integer  "license_id",  :null => false
    t.text     "terms",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :books, :user_id
  add_index :books, :category_id

  create_table "categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :categories, :name, :unique => true

  create_table "chapters", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "parent_id",   :null => false
    t.string   "parent_type", :null => false
    t.string   "type"
    t.string   "title",       :null => false
    t.integer  "position",    :null => false
    t.text     "content",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :chapters, [:parent_id, :parent_type, :type]

  create_table "comments", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.string   "commentable_type", :null => false
    t.integer  "commentable_id",   :null => false
    t.boolean  "vote"              
    t.text     "content",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :comments, :user_id

  create_table "licenses", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "image_src"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :licenses, :url, :unique => true

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "book_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :notifications, [:user_id, :book_id], :unique => true

  create_table "users", :force => true do |t|
    t.string :full_name,                      :limit => 100, :default => '', :null => true
    t.string :email,                     :limit => 100
    t.string   "image"
    t.text     "description"
    t.boolean  "is_admin",    :default => false
    t.string :login, :crypted_password, :salt, :remember_token, :limit => 40
    t.datetime :remember_token_expires_at
    t.string :activation_code,           :limit => 40
    t.datetime :activated_at
    t.string :state,                     :null => :no, :default => 'passive'
    t.datetime :deleted_at
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index :users, :login, :unique => true

end
