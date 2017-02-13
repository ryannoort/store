class MetadataSet < ApplicationRecord
	has_and_belongs_to_many :items
	has_many :metadata_fields, dependent: :destroy
	# has_many :metadata_fields, through: :items_fields_values
end
