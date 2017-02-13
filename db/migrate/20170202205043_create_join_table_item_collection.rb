class CreateJoinTableItemCollection < ActiveRecord::Migration[5.0]
  def change
		create_join_table :items, :collections do |t|
			t.index [:item_id, :collection_id]
			t.index [:collection_id, :item_id]
		end
  end
end
