json.extract! metadata_set, :id, :name
json.url metadata_set_url(metadata_set, format: :json)
json.metadata_fields @metadata_set.metadata_fields do |metadata_field|
	json.id metadata_field.id
	json.field_type metadata_field.field_type
	json.name metadata_field.name
	json.hint metadata_field.hint
	json.default metadata_field.default
	json.order metadata_field.order
	json.is_required metadata_field.is_required
end
