class FormDefinition
	def initialize(schema, name, description, type)
		@schema = schema
		@name = name
		@description = description
		@type = type
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