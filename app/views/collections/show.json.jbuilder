# json.partial! "collections/collection", collection: @collection

json.extract! @collection, :id, :name, :item_ids, :collection_ids
json.url collection_url(@collection, format: :json)
json.partial! 'application/metadata_type_values', object: @item_type



# json.collection do
# 	json.partial! 'application/metadata_type_values', object: @item_type
# end