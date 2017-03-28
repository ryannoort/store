json.page @item_page
json.per_page @item_per_page
json.count @item_count

json.items @items do |item|
	json.partial! 'item_node', locals: {item: item}
end