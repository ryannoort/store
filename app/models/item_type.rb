class ItemType < ApplicationRecord
	has_and_belongs_to_many :metadata_sets
	accepts_nested_attributes_for :metadata_sets

	scope :item_type_values, -> (metadatable) {
		includes(metadata_sets: 
			[metadata_fields: [:metadata_values] ])
			.where(
				item_types: 
				{id: metadatable.item_type_id} , 
				metadata_values: 
				{valuable_type: metadatable.class.name, 
				valuable_id: metadatable.id}) 
	}


	# TODO This is not needed, remove and tests
	attr_accessor :metadata_sets_ids
	after_save :update_item_type_metadata_sets

	def update_item_type_metadata_sets

		# check for _destroy
		self.metadata_sets.clear
    metadata_sets_ids.each do |key, metadata_set_id|        
      metadata_set = MetadataSet.find metadata_set_id['id']
      if metadata_set
        self.metadata_sets << metadata_set
      end
    end

	end


end
