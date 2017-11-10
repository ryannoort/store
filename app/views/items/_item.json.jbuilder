json.extract! item, :id, :name, :location, :is_public
if item.start_time.present?
	json.start_time item.start_time.to_s :year_month_day
end
if item.end_time.present?
	json.end_time item.end_time.to_s :year_month_day
end
# json.url item_url(item, format: :json)

json.feature item.feature_as_json


json.url item_url(item)
json.partial! 'application/metadata_type_values', object: item.item_type_values

