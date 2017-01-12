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

ActiveRecord::Schema.define(version: 20170112221520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_topology"

  create_table "collections", force: :cascade do |t|
    t.string   "name",                 null: false
    t.integer  "form_id",              null: false
    t.integer  "owner_id"
    t.integer  "parent_collection_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "collections_items", id: false, force: :cascade do |t|
    t.integer "collection_id"
    t.integer "item_id"
    t.index ["collection_id"], name: "index_collections_items_on_collection_id", using: :btree
    t.index ["item_id"], name: "index_collections_items_on_item_id", using: :btree
  end

  create_table "fields", id: false, force: :cascade do |t|
    t.string   "name"
    t.integer  "form_id"
    t.text     "content"
    t.string   "mime_type"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_fields_on_form_id", using: :btree
    t.index ["name"], name: "index_fields_on_name", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.integer  "schema_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

# Could not dump table "items" because of following StandardError
#   Unknown type 'geometry' for column 'location'

  create_table "schemas", force: :cascade do |t|
    t.string   "name"
    t.text     "xml_content"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.datetime "last_log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "collections", "collections", column: "parent_collection_id"
  add_foreign_key "collections", "forms"
  add_foreign_key "fields", "forms"
  add_foreign_key "forms", "schemas"
  add_foreign_key "items", "forms"
end
