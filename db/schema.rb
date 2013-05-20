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

ActiveRecord::Schema.define(:version => 20130520062249) do

  create_table "activities", :force => true do |t|
    t.string   "activity_type"
    t.string   "provider"
    t.float    "duration"
    t.float    "distance"
    t.datetime "activity_date"
    t.string   "activity_id"
    t.integer  "user_id"
    t.boolean  "detail_present", :default => false
    t.text     "run_detail"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "app_providers", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "uid"
    t.string   "access_token"
  end

  create_table "routes", :force => true do |t|
    t.string   "name"
    t.text     "path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "runs", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "name"
    t.date     "run_date"
    t.time     "run_start_time"
    t.text     "details"
    t.integer  "route_id"
    t.integer  "organizer_id"
    t.boolean  "cancelled",      :default => false
  end

  create_table "user_runs", :force => true do |t|
    t.integer  "run_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "status"
    t.string   "email",              :default => ""
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

end
