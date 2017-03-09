class ItemType < ApplicationRecord
	
	# belongs_to :itemable, polymorphic: true
	has_and_belongs_to_many :metadata_sets
	
end
