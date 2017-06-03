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

ActiveRecord::Schema.define(version: 20170603153549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_books", force: :cascade do |t|
    t.string  "name"
    t.string  "last_name"
    t.string  "phone"
    t.string  "email"
    t.integer "user_id"
    t.boolean "is_private", default: false
    t.index ["id", "user_id"], name: "index_address_books_on_id_and_user_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_address_books_on_user_id", using: :btree
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "name"
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "author_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.string   "last_name"
    t.datetime "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "number"
    t.string   "title"
    t.datetime "published_at"
    t.integer  "author_id"
    t.decimal  "price",          default: "10.0"
    t.integer  "lock_increment", default: 0
    t.index ["author_id"], name: "index_books_on_author_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string  "comment"
    t.integer "score"
    t.integer "book_id"
    t.integer "feedbacker_id"
    t.boolean "whitelist",     default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.datetime "birth_date"
    t.string   "pin"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "lock_version",          default: 0
    t.integer  "private_address_count", default: 0
  end

  add_foreign_key "address_books", "users"
  add_foreign_key "addresses", "authors"
  add_foreign_key "books", "authors"
  add_foreign_key "feedbacks", "books"
  add_foreign_key "feedbacks", "users", column: "feedbacker_id"
end
