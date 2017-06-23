class MetadataField < ApplicationRecord

	enum field_type: {
		text_field: 0,
		text_area: 1,
		file: 2,
		image: 3,
		email: 4,
		url: 5,
		number: 6,
		rich_text: 7
	}
	
	belongs_to :metadata_set
	has_many :metadata_values, dependent: :destroy
end
