class FormDefinition
	def initialize(schema, form_data)
		@schema = schema
		@name = form_data["name"]
		@description = form_data["description"]
		@type = form_data["type"]
		@fields = Array.new
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