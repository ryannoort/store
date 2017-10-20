class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.string :name, null: false
      t.belongs_to :owner, null: false
      t.belongs_to :collection # parent collection
      t.belongs_to :item_type, null: false
      t.boolean :is_public, null: false, default: false
      t.timestamps
    end
  end
end