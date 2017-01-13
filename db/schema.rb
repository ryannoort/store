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

ActiveRecord::Schema.define(version: 20170113201714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

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
    t.index ["collection_id", "item_id"], name: "index_collections_items_on_collection_id_and_item_id", unique: true, using: :btree
    t.index ["collection_id"], name: "index_collections_items_on_collection_id", using: :btree
    t.index ["item_id"], name: "index_collections_items_on_item_id", using: :btree
  end

  create_table "fields", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "form_id",    null: false
    t.text     "content"
    t.string   "mime_type"
    t.integer  "type",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "hint"
    t.index ["form_id"], name: "index_fields_on_form_id", using: :btree
    t.index ["name", "form_id"], name: "index_fields_on_name_and_form_id", unique: true, using: :btree
    t.index ["name"], name: "index_fields_on_name", using: :btree
  end

  create_table "forms", force: :cascade do |t|
    t.integer  "schema_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",                                             null: false
    t.geometry "location",   limit: {:srid=>0, :type=>"geometry"}
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "form_id",                                          null: false
    t.boolean  "is_public",                                        null: false
    t.integer  "owner_id",                                         null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "schemas", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "xml_content", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "email",      null: false
    t.string   "image"
    t.datetime "last_log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

  add_foreign_key "collections", "collections", column: "parent_collection_id"
  add_foreign_key "collections", "forms"
  add_foreign_key "fields", "forms"
  add_foreign_key "forms", "schemas"
  add_foreign_key "items", "forms"
end
