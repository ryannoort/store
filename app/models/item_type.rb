class ItemType < ApplicationRecord
	has_and_belongs_to_many :metadata_sets
	accepts_nested_attributes_for :metadata_sets

	scope :fetch_for_item, -> (item) {
		includes(metadata_sets: [metadata_fields: [:metadata_values] ])
			.where(item_types: {id: item.item_type_id} , metadata_values: {valuable_type: item.class.name, valuable_id: item.id}) 
	}


	# TODO This is not needed, remove and tests
	attr_accessor :metadata_sets_ids
	after_save :update_item_type_metadata_sets

	def update_item_type_metadata_sets
		self.metadata_sets.clear
    metadata_sets_ids.each do |key, metadata_set_id|        
      metadata_set = MetadataSet.find metadata_set_id['id']
      if metadata_set
        self.metadata_sets << metadata_set
      end
    end 		
	end


end
