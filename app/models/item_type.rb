class ItemType < ApplicationRecord
	has_and_belongs_to_many :metadata_sets
	
	scope :fetch_for_item, -> (item) {
		includes(metadata_sets: [metadata_fields: [:metadata_values] ])
			.where(item_types: {id: item.item_type_id} , metadata_values: {valuable_type: item.class.name, valuable_id: item.id}) 
	}
	
end
