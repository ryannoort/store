class ItemType < ApplicationRecord
	has_and_belongs_to_many :metadata_sets
end
