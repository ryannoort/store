class CreateSchemas < ActiveRecord::Migration[5.0]
  def change
    create_table :schemas do |t|
      t.string :name
      t.text :xml_content
      t.string :type
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
