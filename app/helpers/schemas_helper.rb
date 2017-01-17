module SchemasHelper
	def create_instance(schema_id)
		schema = Schema.find(schema_id)
		xml_data = MultiXml.parse(schema.xml_content)["Schema"]

		result = nil

		case xml_data["type"]
		when "Collection"
			result = Collection.new()
		when "Item"
			result = Item.new()
		end

		if result == nil
			return nil
		end

		result.form = create_form(xml_data["Fields"])
		result.form.schema_id = schema_id

		puts xml_data.inspect
		puts result.inspect

		return result
	end

	private
		def create_form(xml_data)
			form = Form.new()
			field_array = xml_data["Field"]

			field_array.each do |field_data|
				field = create_form_field(field_data)
				form.fields.push(field)
			end

			return form
		end	

		def create_form_field(xml_data)
			field = Field.new()

			return field
		end
end
