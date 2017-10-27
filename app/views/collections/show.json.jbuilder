# json.partial! "collections/collection", collection: @collection
json.extract! @collection, :id, :name
# json.url collection_url(@collection, format: :json)
json.url collection_url(@collection)
json.partial! 'application/metadata_type_values', object: @collection.item_type_values




