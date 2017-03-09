class MetadataSet < ApplicationRecord
	has_many :metadata_fields, dependent: :destroy
	has_and_belongs_to_many :item_types
	accepts_nested_attributes_for :metadata_fields, allow_destroy: true
	# has_many :metadata_fields, through: :items_fields_values
end
