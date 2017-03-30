
window.storeViewModels ?= {}

storeViewModels.CollectionsViewModel = ->
	self = this
	self.collections = ko.observableArray []
	# toggle checkboxes
	self.itemsSelectable = false
	self.collectionsSelectable = false
	# selected will keep a list of selected object ids to reset when page has changed
	selected =
		items: []
		collections: []

	# callbacks
	self.mouseOver = (node) ->
		return

	self.mouseOut = (node) ->
		return

	self.clicked = (node) ->
		return

	self.checked = (node) ->
		return 

	self.getSelected = () ->
		return selected

	self.updateCollections = (data) ->
		collections = data.collections
		collections.forEach (e) ->
			travelHierarchy e, addCheckValues
		self.collections collections
		applyCheckValuesToPage()

	isCollection = (node) ->
		node.collections?

	removeIdFromArray = (array, node) ->
		 index = array.indexOf node.id
		 array.splice(index, 1) if index > -1

	addIdToArray = (array, node) ->
		index = array.indexOf node.id
		array.push node.id if index == -1

	getSelectedArray = (node)	->
		if isCollection node then selected.collections else selected.items

	setCheckedValues = (node) ->
		array = getSelectedArray node
		node.isChecked( array.indexOf(node.id) != -1 )

	applyCheckValuesToPage = ->
		self.collections().forEach (e) ->
			travelHierarchy e, setCheckedValues

	changeSelectedValue = (node) ->
		applyTo = if node.isChecked() then addIdToArray else removeIdFromArray
		array = getSelectedArray node
		applyTo array, node
		# self.selected(self.getSelected)
		

	travelHierarchy = (node, callback) ->
		callback(node)

		if node.collections
			node.collections.forEach (e) ->
				travelHierarchy e, callback

		if node.items
			node.items.forEach (e) ->
				travelHierarchy e, callback				

	addCheckValues = (node) ->		
		node.isChecked = ko.observable(false)
		node.isChecked.subscribe (value) ->
			changeSelectedValue node

	console.log ""