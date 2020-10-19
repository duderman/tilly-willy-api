# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_19_085537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "checkout_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "checkout_id", null: false
    t.uuid "product_id", null: false
    t.uuid "discount_id", null: false
    t.integer "price_cents", null: false
    t.string "price_currency", default: "GBP", null: false
    t.integer "discount_price_cents"
    t.string "discount_price_currency", default: "GBP", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_id"], name: "index_checkout_items_on_checkout_id"
    t.index ["discount_id"], name: "index_checkout_items_on_discount_id"
    t.index ["product_id"], name: "index_checkout_items_on_product_id"
  end

  create_table "checkouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type", null: false
    t.integer "percentage"
    t.integer "price_cents"
    t.string "price_currency", default: "GBP", null: false
    t.jsonb "configuration", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", null: false
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_products_on_code", unique: true
  end

  add_foreign_key "checkout_items", "checkouts"
  add_foreign_key "checkout_items", "discounts"
  add_foreign_key "checkout_items", "products"
end
