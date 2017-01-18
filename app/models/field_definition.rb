class FieldDefinition
	def initialize(name, label, type, default, hint, is_required)
		@name = name
		@label = label
		@type = type
		@default = default
		@hint = hint
		@is_required = "true" == is_required
		@order = 0
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