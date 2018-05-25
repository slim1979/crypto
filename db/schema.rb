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

ActiveRecord::Schema.define(version: 20180525135454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candles", force: :cascade do |t|
    t.bigint "pair_id"
    t.string "timestamp"
    t.string "open"
    t.string "close"
    t.string "min"
    t.string "max"
    t.string "volume"
    t.string "volumeQuote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pair_id"], name: "index_candles_on_pair_id"
  end

  create_table "orderbooks", force: :cascade do |t|
    t.bigint "pair_id"
    t.string "ask"
    t.string "bid"
    t.string "size"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pair_id"], name: "index_orderbooks_on_pair_id"
  end

  create_table "pairs", force: :cascade do |t|
    t.string "symbols"
    t.string "baseCurrency"
    t.string "quoteCurrency"
    t.string "quantityIncrement"
    t.string "tickSize"
    t.string "takeLiquidityRate"
    t.string "provideLiquidityRate"
    t.string "feeCurrency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickers", force: :cascade do |t|
    t.string "ask"
    t.string "bid"
    t.string "last"
    t.string "open"
    t.string "low"
    t.string "high"
    t.string "volume"
    t.string "volumeQuote"
    t.string "timestamp"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trades", force: :cascade do |t|
    t.bigint "pair_id"
    t.string "trade_id"
    t.string "price"
    t.string "quantity"
    t.string "side"
    t.string "timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pair_id"], name: "index_trades_on_pair_id"
  end

  add_foreign_key "candles", "pairs"
  add_foreign_key "trades", "pairs"
end
