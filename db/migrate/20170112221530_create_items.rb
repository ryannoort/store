class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.geometry :location
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :is_public, null: false, default: false
      t.belongs_to :owner
      t.belongs_to :item_type
      t.timestamps
    end
    add_index :items, :location, using: :gist
  end
end
