# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130217202119) do

  create_table "entries", :force => true do |t|
    t.string   "content"
    t.string   "link"
    t.string   "title"
    t.datetime "published"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "feed_id"
    t.string   "photo_id"
    t.integer  "favorite_cnt"
  end

  add_index "entries", ["content"], :name => "index_entries_on_content", :unique => true
  add_index "entries", ["favorite_cnt"], :name => "index_entries_on_favorite_cnt"
  add_index "entries", ["published"], :name => "index_entries_on_published"

  create_table "feeds", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.string   "etag"
    t.datetime "last_modified"
    t.boolean  "fetched_ok"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "site_url"
  end

  add_index "feeds", ["url"], :name => "index_feeds_on_url", :unique => true

end
