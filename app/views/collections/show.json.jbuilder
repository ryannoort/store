json.collection @collection, :id, :name
json.url collection_url(@collection, format: :json)

json.collection do
	json.partial! 'application/metadata_type_values', object: @item_type
end

# json.partial! "collections/collection", collection: @collection