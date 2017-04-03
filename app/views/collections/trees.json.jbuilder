json.page @collection_page
json.per_page @collection_per_page
json.count @collection_count

json.collections @collections do |collection|
	json.partial! 'tree_node', locals: {collection: collection}
end