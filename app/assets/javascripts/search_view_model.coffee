window.storeViewModels ?= {}

storeViewModels.SearchViewModel = ->
	self = this

	self.page = ko.observable 1
	self.pages = ko.observable 1
	self.query = ko.observable ""
	perPage = 2
	resultsCount = 0
	registrations = []	

	self.search = ->
		self.page 1
		fetchPage()

	self.prevPage = () ->
		if self.page() > 1
			self.page(self.page() - 1 )
			fetchPage()

	self.nextPage = () ->

		if self.page() < self.pages()
			self.page(self.page() + 1)
			fetchPage()

	self.registerUpdate = (f) ->
		registrations.push f

	callRegistrations = (data) ->
		registrations.forEach (f) ->
			f(data)


	setPaginationData = (data) ->
		self.page(data.page)
		resultsCount = data.count
		self.pages Math.ceil(resultsCount / perPage)


	fetchPage = () ->
		data =
			page: self.page()
			per_page: perPage
			name: self.query()

		$.ajax(
			type: 'GET'
			data: data
			dataType: "json"
			url: '/items/search.json'
			success: (data) ->
				data.collections = [
					{
						id: 0,
						name: "Items",
						items: data.items
						collections: []
					}
				]
				setPaginationData data
				callRegistrations data
		)

	fetchPage()

	console.log ""


# window.storeViewModels ?= {}

# storeViewModels.SearchViewModel = ->
# 	self = this

# 	self.page = ko.observable 1
# 	self.pages = ko.observable 1
# 	self.query = ko.observable ""
# 	perPage = 5
# 	resultsCount = 0
# 	registrations = []	

# 	self.search = ->
# 		self.page 1
# 		console.log self.query()
# 		fetchPage()

# 	self.prevPage = () ->
# 		if self.page() > 1
# 			self.page(self.page() - 1 )
# 			fetchPage()

# 	self.nextPage = () ->

# 		if self.page() < self.pages()
# 			self.page(self.page() + 1)
# 			fetchPage()

# 	self.registerUpdate = (f) ->
# 		registrations.push f

# 	callRegistrations = (data) ->
# 		registrations.forEach (f) ->
# 			f(data)


# 	setPaginationData = (data) ->
# 		self.page(data.page)
# 		resultsCount = data.count
# 		self.pages Math.ceil(resultsCount / perPage)


# 	fetchPage = () ->
# 		data =
# 			page: self.page()
# 			per_page: perPage
# 			query: self.query()

# 		$.ajax(
# 			type: 'GET'
# 			data: data
# 			dataType: "json"
# 			url: '/collections/trees.json'
# 			success: (data) ->
# 				setPaginationData data
# 				callRegistrations data
# 		)

# 	fetchPage()

# 	console.log ""