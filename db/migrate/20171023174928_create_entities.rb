class CreateEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :entities do |t|
      t.string :name, null: false
      t.belongs_to :owner, null: false
      t.belongs_to :item_type, null: false
      t.boolean :is_public, null: false, default: false

      t.geometry :location
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
	add_index :entities, :location, using: :gist
  end
end
