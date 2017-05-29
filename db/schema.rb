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

ActiveRecord::Schema.define(version: 20170529071754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["author_id"], name: "index_books_on_author_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string  "comment"
    t.integer "score"
    t.string  "feedbacker"
    t.integer "book_id"
  end

  add_foreign_key "addresses", "authors"
  add_foreign_key "books", "authors"
  add_foreign_key "feedbacks", "books"
end
