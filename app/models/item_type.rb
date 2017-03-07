class ItemType < ApplicationRecord
	has_and_belongs_to_many :metadata_sets

	has_many :items
	# TODO This is not needed, remove and test
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
