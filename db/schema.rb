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

ActiveRecord::Schema.define(:version => 20120716153146) do

  create_table "devices", :force => true do |t|
    t.string   "device_id"
    t.string   "reg_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
  end

  add_index "devices", ["user_id"], :name => "index_devices_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "origin"
    t.string   "message"
    t.string   "timestamp"
    t.integer  "user_id"
    t.string   "destination"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "outmessages", :force => true do |t|
    t.string   "destination"
    t.string   "message"
    t.string   "timestamp"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outmessages", ["user_id"], :name => "index_outmessages_on_user_id"

  create_table "synchashes", :force => true do |t|
    t.string   "in_hash"
    t.string   "out_hash"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "synchashes", ["user_id"], :name => "index_synchashes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
