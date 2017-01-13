class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.integer :form_id, null: false
      t.integer :owner_id
      t.integer :parent_collection_id

      t.timestamps
    end

    add_foreign_key :collections, :forms
    add_foreign_key :collections, :collections, column: :parent_collection_id

    create_table :collections_items, id: false do |t|
      t.belongs_to :collection, index: true
      t.belongs_to :item, index: true
    end

    add_index :collections_items, [:collection_id, :item_id], unique: true
  end
end