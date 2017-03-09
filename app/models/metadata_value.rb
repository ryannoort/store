class MetadataValue < ApplicationRecord
	belongs_to :item
	belongs_to :metadata_field
end
