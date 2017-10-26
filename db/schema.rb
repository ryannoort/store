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

ActiveRecord::Schema.define(version: 20171023193113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "child_entities", force: :cascade do |t|
    t.integer  "entity_id"
    t.integer  "child_entity_id"
    t.integer  "order"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["child_entity_id"], name: "index_child_entities_on_child_entity_id", using: :btree
    t.index ["entity_id"], name: "index_child_entities_on_entity_id", using: :btree
  end

  create_table "collections", force: :cascade do |t|
    t.string   "name",                          null: false
    t.integer  "owner_id",                      null: false
    t.integer  "collection_id"
    t.integer  "item_type_id",                  null: false
    t.boolean  "is_public",     default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["collection_id"], name: "index_collections_on_collection_id", using: :btree
    t.index ["item_type_id"], name: "index_collections_on_item_type_id", using: :btree
    t.index ["owner_id"], name: "index_collections_on_owner_id", using: :btree
  end

  create_table "collections_items", id: false, force: :cascade do |t|
    t.integer "collection_id", null: false
    t.integer "item_id",       null: false
    t.index ["collection_id", "item_id"], name: "index_collections_items_on_collection_id_and_item_id", using: :btree
    t.index ["item_id", "collection_id"], name: "index_collections_items_on_item_id_and_collection_id", using: :btree
  end

  create_table "entities", force: :cascade do |t|
    t.string   "name",                                                               null: false
    t.integer  "owner_id",                                                           null: false
    t.integer  "item_type_id",                                                       null: false
    t.boolean  "is_public",                                          default: false, null: false
    t.geometry "location",     limit: {:srid=>0, :type=>"geometry"}
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "type"
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.index ["item_type_id"], name: "index_entities_on_item_type_id", using: :btree
    t.index ["location"], name: "index_entities_on_location", using: :gist
    t.index ["owner_id"], name: "index_entities_on_owner_id", using: :btree
  end

  create_table "item_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_types_metadata_sets", id: false, force: :cascade do |t|
    t.integer "item_type_id"
    t.integer "metadata_set_id"
    t.index ["item_type_id"], name: "index_item_types_metadata_sets_on_item_type_id", using: :btree
    t.index ["metadata_set_id"], name: "index_item_types_metadata_sets_on_metadata_set_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",                                                               null: false
    t.geometry "location",     limit: {:srid=>0, :type=>"geometry"}
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "is_public",                                          default: false, null: false
    t.integer  "owner_id",                                                           null: false
    t.integer  "item_type_id",                                                       null: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.index ["location"], name: "index_items_on_location", using: :gist
    t.index ["owner_id"], name: "index_items_on_owner_id", using: :btree
  end

  create_table "metadata_fields", force: :cascade do |t|
    t.integer  "field_type",      null: false
    t.string   "name",            null: false
    t.string   "hint"
    t.string   "default"
    t.boolean  "is_required",     null: false
    t.integer  "order"
    t.integer  "metadata_set_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["metadata_set_id"], name: "index_metadata_fields_on_metadata_set_id", using: :btree
  end

  create_table "metadata_sets", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metadata_values", force: :cascade do |t|
    t.string   "value"
    t.integer  "metadata_field_id"
    t.string   "valuable_type"
    t.integer  "valuable_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["metadata_field_id"], name: "index_metadata_values_on_metadata_field_id", using: :btree
    t.index ["valuable_type", "valuable_id"], name: "index_metadata_values_on_valuable_type_and_valuable_id", using: :btree
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
