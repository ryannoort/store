class CreateJoinTableMetadataSetItem < ActiveRecord::Migration[5.0]
  def change
		create_table :items_metadata_sets, id: false do |t|
      t.belongs_to :item, index: true
     	t.belongs_to :metadata_set, index: true
   	end
  #  	create_join_table :metadata_sets, :collections do |t|
		# 	t.index [:metadata_set_id, :collection_id]
		# 	t.index [:collection_id, :metadata_set_id]
		# end
  end
end
