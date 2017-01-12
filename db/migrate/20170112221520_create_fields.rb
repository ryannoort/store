class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields, id: false do |t|
      t.string :name, index: true, :null => false
      t.integer :form_id, index: true, :null => false
      t.text :content
      t.string :mime_type
      t.string :type, :null => false
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
	
	add_foreign_key :fields, :forms
  end
end
