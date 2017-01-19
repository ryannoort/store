class SetCollectionAndItemAsFormParent < ActiveRecord::Migration[5.0]
  def change
  	add_column :forms, :collection_id, :integer
  	add_column :forms, :item_id, :integer

  	add_foreign_key :forms, :collections
    add_foreign_key :forms, :items

    remove_foreign_key :collections, :forms
    remove_foreign_key :items, :forms

    remove_column :collections, :form_id
    remove_column :items, :form_id
  end
end
