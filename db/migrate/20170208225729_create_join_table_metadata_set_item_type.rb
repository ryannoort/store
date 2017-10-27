class CreateJoinTableMetadataSetItemType < ActiveRecord::Migration[5.0]
  def change
		create_table :item_types_metadata_sets, id: false do |t|
      t.belongs_to :item_type, index: true
     	t.belongs_to :metadata_set, index: true
   	end
  end
end
