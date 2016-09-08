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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160908181002) do

  create_table "books", force: :cascade do |t|
    t.string   "isbn"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books_carts", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "cart_id"
  end

  add_index "books_carts", ["book_id"], name: "index_books_carts_on_book_id"
  add_index "books_carts", ["cart_id"], name: "index_books_carts_on_cart_id"

  create_table "books_sales", force: :cascade do |t|
    t.integer "book_id"
    t.integer "sale_id"
  end

  add_index "books_sales", ["book_id"], name: "index_books_sales_on_book_id"
  add_index "books_sales", ["sale_id"], name: "index_books_sales_on_sale_id"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "owner"
    t.string   "number"
    t.date     "expiration_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer  "credit_card_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "total_price"
    t.integer  "user_id"
  end

  add_index "sales", ["credit_card_id"], name: "index_sales_on_credit_card_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
