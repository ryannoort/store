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

ActiveRecord::Schema.define(version: 20170202205043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "collections", force: :cascade do |t|
    t.string   "name",          null: false
    t.integer  "owner_id"
    t.integer  "collection_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["collection_id"], name: "index_collections_on_collection_id", using: :btree
    t.index ["owner_id"], name: "index_collections_on_owner_id", using: :btree
  end

  create_table "fields", force: :cascade do |t|
    t.string   "name",           null: false
    t.text     "content"
    t.integer  "type",           null: false
    t.string   "hint"
    t.string   "fieldable_type"
    t.integer  "fieldable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["fieldable_type", "fieldable_id"], name: "index_fields_on_fieldable_type_and_fieldable_id", using: :btree
    t.index ["name"], name: "index_fields_on_name", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",                                                             null: false
    t.geometry "location",   limit: {:srid=>0, :type=>"geometry"}
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "is_public",                                        default: false, null: false
    t.integer  "schema_id"
    t.integer  "owner_id"
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.index ["location"], name: "index_items_on_location", using: :gist
    t.index ["owner_id"], name: "index_items_on_owner_id", using: :btree
    t.index ["schema_id"], name: "index_items_on_schema_id", using: :btree
  end

  create_table "items_collections", id: false, force: :cascade do |t|
    t.integer "item_id"
    t.integer "collection_id"
    t.index ["collection_id"], name: "index_items_collections_on_collection_id", using: :btree
    t.index ["item_id"], name: "index_items_collections_on_item_id", using: :btree
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
    t.integer  "role",       null: false
    t.string   "email",      null: false
    t.string   "image_url"
    t.datetime "last_log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
  end

end
