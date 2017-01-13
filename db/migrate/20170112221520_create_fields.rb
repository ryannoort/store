class CreateFields < ActiveRecord::Migration[5.0]
  def change
      create_table :fields, id: false do |t|
      t.string :name, index: true, :null => false
      t.integer :form_id, index: true, :null => false
      t.text :content
      t.string :mime_type
      t.integer :type, :null => false

      t.timestamps
    end

    add_foreign_key :fields, :forms
  end
end
