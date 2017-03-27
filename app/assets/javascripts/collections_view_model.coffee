window.storeViewModels = {}
storeViewModels.CollectionsViewModel = ->
	self = this
	self.collections = ko.observableArray []
	# selected will keep a list of selected object ids to reset when page has changed
	selectedItems = []
	selectedCollections = []

	self.page = ko.observable 1
	self.pages = ko.observable 1
	perPage = 2
	collectionsCount = 0

	self.mouseOver = (node) ->
		console.log "mouseOver " + node

	self.clicked = (node) ->
		console.log "clicked " + node

	self.selected = () ->
		console.log self.getSelected()

	self.getSelected = () ->
		{
			items: selectedItems,
			collections: selectedCollections
		}

	# XXX Move pagination to outside of widget

	self.prevPage = () ->
		if self.page() > 1
			self.page(self.page() - 1 )
			fetchPage()

	self.nextPage = () ->

		if self.page() < self.pages()
			self.page(self.page() + 1)
			fetchPage()

	setPaginationData = (data) ->
		collections = data.collections
		self.page(data.page)
		# perPage = data.per_page
		collectionsCount = data.count
		self.pages Math.ceil(collectionsCount / perPage)
		
		collections.forEach (e) ->
			travelHierarchy e, addCheckValues
		self.collections collections

	fetchPage = () ->
		data =
			page: self.page()
			per_page: perPage

		$.ajax(
			type: 'GET'
			data: data
			dataType: "json"
			url: '/collections/trees.json'
			success: (data) ->
				setPaginationData data
				applyCheckValuesToPage()
		)

	fetchPage()

	# End of pagination code

	isCollection = (node) ->
		node.collections?

	removeIdFromArray = (array, node) ->
		 index = array.indexOf node.id
		 array.splice(index, 1) if index > -1

	addIdToArray = (array, node) ->
		index = array.indexOf node.id
		array.push node.id if index == -1

	getSelectedArray = (node)	->
		if isCollection node then selectedCollections else selectedItems

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
		applyCheckValuesToPage()
		self.selected()
		

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