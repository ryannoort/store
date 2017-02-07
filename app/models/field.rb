class Field < ApplicationRecord
	self.inheritance_column = :_type_disabled
	# belongs_to :form, :inverse_of => :fields	
	
	enum type: {
		text_field: 0,
		text_area: 1,
		file: 2,
		image: 3,
		email: 4,
		url: 5,
		number: 6
	}
	
	belongs_to :fieldable, polymorphic: true

	# def definition
	# 	form_definition = self.form

	# 	field_index = form_definition.fields.index { |item| item.name == self.name }

	# 	return form_definition.fields[field_index]
	# end
end
