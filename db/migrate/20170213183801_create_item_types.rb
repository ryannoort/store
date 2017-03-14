class CreateItemTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :item_types do |t|
    	t.string :name
    	# t.references :itemable, polymorphic: true, index: true
      t.timestamps
    end
  end
end