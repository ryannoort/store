class Field < ApplicationRecord
	belongs_to :form, :inverse_of => :fields	
	
	enum type: {
		text_field: 0,
		text_area: 1,
		file: 2,
		image: 3,
		email: 4,
		url: 5,
		number: 6
	}
	
end
