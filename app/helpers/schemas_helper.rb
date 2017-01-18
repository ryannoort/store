module SchemasHelper
	def get_form_definition(schema_id)
		schema = Schema.find(schema_id)
		xml_data = MultiXml.parse(schema.xml_content)["Schema"]

		form_definition = FormDefinition.new(schema, xml_data["name"], xml_data["description"], xml_data["type"])

		field_array = xml_data["Fields"]["Field"]

		field_array.each do |field_data|
			field = FieldDefinition.new(field_data["name"], field_data["label"], field_data["type"], field_data["definition"], field_data["hint"], field_data["required"])
			form_definition.fields.push(field)
		end

		return form_definition
	end

	def create_instance(schema_id)
		form_definition = get_form_definition(schema_id)

		result = nil

		case form_definition.type
		when "Collection"
			result = Collection.new
		when "Item"
			result = Item.new
		end

		if result == nil
			return nil
		end

		result.form = create_form(form_definition)

		puts result.inspect
		puts result.form.inspect
		result.form.fields do |field|
			puts field.inspect
		end

		return result
	end

	private
		def create_form(form_definition)
			form = Form.new()
			form.schema = form_definition.schema

			form_definition.fields do |field_definition|
				field = create_form_field(field_definition)
				field.form = form
				form.fields.push(field)
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
