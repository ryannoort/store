class ItemType < ApplicationRecord
	has_and_belongs_to_many :metadata_sets
	# has_many :item_types_metadata_sets
	# has_many :metadata_sets, through: :item_types_metadata_sets
	# accepts_nested_attributes_for :metadata_sets
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
