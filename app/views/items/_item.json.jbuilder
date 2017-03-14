json.extract! item, :id, :name, :start_time, :end_time, :location, :is_public
# json.url item_url(item, format: :json)
json.url item_url(item)
json.partial! 'application/metadata_type_values', object: item.item_type_values

