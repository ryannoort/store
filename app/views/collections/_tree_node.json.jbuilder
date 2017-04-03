json.extract! collection, :id, :name
json.items collection.items do |item|
	json.extract! item, :id, :name, :location
end

max_depth ||= CONFIG["collection_max_depth"].to_i

if max_depth > 0
	json.collections collection.collections do |collection|
		json.partial! 'tree_node', locals: {collection: collection, max_depth: max_depth - 1}
	end
end