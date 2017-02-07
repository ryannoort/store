class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.string :name, index: true, null: false
      t.text :content
      t.integer :type, null: false
      t.string :hint
      t.references :fieldable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
