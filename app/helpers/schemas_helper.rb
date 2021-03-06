module SchemasHelper
	def get_form_definition(schema_id)
		schema = Schema.find(schema_id)
		return schema.get_form_definition
	end

	def create_instance(schema_id, collection_id = nil)
		form_definition = get_form_definition(schema_id)

		result = nil

		# Create the base object
		case form_definition.type
		when "Collection"
			result = Collection.new
		when "Item"
			result = Item.new
		end

		if result == nil
			return nil
		end

		# Create the form for the object
		result.form = create_form(form_definition)

		# If a collection is defined, attach the result to it.
		if(collection_id != nil)
			collection = Collection.find(collection_id)

			case form_definition.type
			when "Collection"
				result.parent_collection = collection
			when "Item"
				result.collections << collection
			end
		end

		return result
	end

	private
		def create_form(form_definition)
			form = Form.new()
			form.schema = form_definition.schema

			form_definition.fields.each do |field_definition|
				field = create_form_field(field_definition)
				field.form = form
				form.fields << field
			end

			return form
		end

		def create_form_field(field_definition)
			field = Field.new

			field.type = field_definition.type
			field.name = field_definition.name
			field.content = field_definition.default

			return field
		end
end
