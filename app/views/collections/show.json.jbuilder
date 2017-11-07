# json.partial! "collections/collection", collection: @collection
json.extract! @collection, :id, :name, :is_public
# json.url collection_url(@collection, format: :json)
json.url collection_url(@collection)
json.partial! 'application/metadata_type_values', object: @collection.item_type_values


json.children @collection.children do |child|
	json.id child.id
	json.name child.name
	json.type child.type
end
