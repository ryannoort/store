json.extract! collection, :id, :name
json.items collection.items do |item|
	json.extract! item, :id, :name
end

json.collections collection.collections do |collection|
	json.partial! 'tree_node', locals: {collection: collection}
end