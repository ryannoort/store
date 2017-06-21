
window.storeViewModels ?= {}

storeViewModels.CollectionsViewModel = ->
	self = this
	self.collections = ko.observableArray []
	# toggle checkboxes
	self.itemsSelectable = false
	self.collectionsSelectable = false
	self.mouseOverSet = false
	self.mouseOutSet = false
	self.clickedSet = false
	self.checkedSet = false



	# selected will keep a list of selected object ids to reset when page has changed
	selected =
		items: []
		collections: []

	self.test = (items) ->
		selected.items = items;

	# set callbacks
	self.setMouseOver = (f) ->
		self.mouseOver = f
		self.mouseOverSet = true
	
	self.setMouseOut = (f) ->
		self.mouseOut = f
		self.mouseOutSet = true
	
	self.setClicked = (f) ->
		self.clicked = f
		self.clickedSet = true
	
	self.setChecked = (f) ->
		self.checked = f
		self.checkedSet = true

	# callbacks
	self.mouseOver = (node) ->
		false

	self.mouseOut = (node) ->
		false

	self.clicked = (node) ->
		false

	self.checked = (node) ->
		false

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

	getSelectedArray = (node) ->
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
		# console.log node
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