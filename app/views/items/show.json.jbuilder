json.( @item, :id, :name, :start_time, :end_time, :location)
json.url item_url(@item, format: :json)
json.partial! 'application/metadata_type_values', object: @item_type

