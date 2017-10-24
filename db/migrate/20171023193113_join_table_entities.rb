class JoinTableEntities < ActiveRecord::Migration[5.0]
  def change
  	create_table :child_entities do |t|
  		t.integer  :entity_id, index: true
    	t.integer  :child_entity_id, index: true
    	t.integer :order
    	t.timestamps
  	end
  end
end
