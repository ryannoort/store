class MetadataField < ApplicationRecord
	# belongs_to :metadata, class_name: "Metadata"
	enum field_type: {
		text_field: 0,
		text_area: 1,
		file: 2,
		image: 3,
		email: 4,
		url: 5,
		number: 6
	}
	
	belongs_to :metadata_set
	has_many :metadata_values, dependent: :destroy
end
