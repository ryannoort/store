# json.item_types @item_types, :id, :name, :metadata_sets

json.array!(@item_types) do |item_type|
	json.id item_type.id
	json.name item_type.name
	json.metadata_sets item_type.metadata_sets do |metadata_set|
		json.id metadata_set.id
		json.name metadata_set.name
		json.metadata_fields metadata_set.metadata_fields do |metadata_field|
			json.id metadata_field.id
			json.name metadata_field.name
			json.field_type metadata_field.field_type
			json.hint metadata_field.hint
			json.default metadata_field.default
			json.value ""
		end
	end

end