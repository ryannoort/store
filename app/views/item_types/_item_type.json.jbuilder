json.extract! @item_type, :id, :name
# json.url item_type_url(item_type, format: :json)
json.url item_type_url(item_type)
json.metadata_sets @item_type.metadata_sets do |metadata_set|
	json.id metadata_set.id
	json.name metadata_set.name
end
