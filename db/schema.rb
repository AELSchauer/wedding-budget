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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170907183016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banks", force: :cascade do |t|
    t.string   "mx_id"
    t.string   "medium_logo_url"
    t.string   "small_logo_url"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "credentials", force: :cascade do |t|
    t.string   "field_name"
    t.string   "mx_id"
    t.string   "field_label"
    t.string   "field_type"
    t.integer  "bank_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["bank_id"], name: "index_credentials_on_bank_id", using: :btree
  end

  create_table "logs", force: :cascade do |t|
    t.string   "endpoint"
    t.string   "method"
    t.text     "params"
    t.integer  "response_code"
    t.text     "response"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "mx_guid"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "credentials", "banks"
end
