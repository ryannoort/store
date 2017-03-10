json.item_type do
	json.id object.id
	json.name object.name
	json.metadata_sets object.metadata_sets do |metadata_set|
		json.id metadata_set.id
		json.name metadata_set.name
		json.metadata_fields metadata_set.metadata_fields do |metadata_field|
			json.id metadata_field.id
			json.name metadata_field.name
			json.field_type metadata_field.field_type
			json.hint metadata_field.hint
			json.default metadata_field.default
			json.value metadata_field.metadata_values.first.value
		end
	end
end
