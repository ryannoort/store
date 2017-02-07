class CreateSchemas < ActiveRecord::Migration[5.0]
  def change
		create_table :schemas do |t|
			t.string :name, null: false
			t.text :xml_content, null: false
			# t.belongs_to :owner, source: :user
			t.timestamps
    end
  end
end
