class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, :null => false
      t.column :location, :geometry
      t.datetime :start_time
      t.datetime :end_time
      t.integer :form_id, :null => false
      t.boolean :is_public, :null => false
      t.integer :owner_id, :null => false
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
	
	add_foreign_key :items, :forms
  end
end
