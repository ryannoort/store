class FormDefinition
	def initialize(schema, form_data)
		@schema = schema
		@name = form_data["name"]
		@description = form_data["description"]
		@type = form_data["type"]
		@fields = Array.new

		field_array = form_data["Fields"]["Field"]

		field_array.each do |field_data|
			field = FieldDefinition.new(field_data)
			@fields.push(field)
		end
	end

	def schema
		@schema
	end

	def description
		@description
	end

	def name
		@name
	end

	def type
		@type
	end

	def fields
		@fields
	end
end