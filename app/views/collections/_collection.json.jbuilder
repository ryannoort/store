# json.extract! @collection, :id, :name
# json.url collection_url(@collection, format: :json)

# json.collection do
# 	json.partial! 'application/metadata_type_values', object: @item_type
# end

# json.extract! @item_type, :id, :name
# json.url item_type_url(item_type, format: :json)
# json.metadata_sets @item_type.metadata_sets do |metadata_set|
# 	json.id metadata_set.id
# 	json.name metadata_set.name
# end


# json.extract! collection, :id, :created_at, :updated_at
# json.url collection_url(collection, format: :json)


# json.collection @collection, :id, :name
# json.url collection_url(@collection, format: :json)
# json.collection do
# 	json.partial! 'application/metadata_type_values', object: @collection.item_type
# end