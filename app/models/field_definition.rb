class FieldDefinition
	def initialize(field_data)
		@name = field_data["name"]
		@label = field_data["label"]
		@type = field_data["type"]
		@default = field_data["default"]
		@hint = field_data["hint"]
		@is_required = "true" == field_data["required"]
		@order = field_data["order"] == nil ? 0 : Integer(field_data["order"])
	end

	def name
		@name
	end

	def label
		@label
	end

	def type
		@type
	end

	def hint
		@hint
	end

	def is_required
		@is_required
	end

	def default
		@default
	end

	def order
		@order
	end
end