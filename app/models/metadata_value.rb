class MetadataValue < ApplicationRecord
	# belongs_to :metadata, class_name: "Metadata"
	belongs_to :item
	belongs_to :metadata_field
end
