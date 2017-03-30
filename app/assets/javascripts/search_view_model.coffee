window.storeViewModels ?= {}

storeViewModels.SearchViewModel = ->
	self = this

	self.page = ko.observable 1
	self.pages = ko.observable 1
	self.query = ko.observable ""
	
	self.data =
		start_time: ko.observable ""
		end_time: ko.observable ""
		location: ko.observable ""

	perPage = 2
	resultsCount = 0
	registrations = []

	setupTimePickers = ->
		$('#start-time-picker').datetimepicker(
			format: 'YYYY-MM-DD'
		);
		$('#end-time-picker').datetimepicker(
			format: 'YYYY-MM-DD'
			useCurrent: false 
		);
		
		$('#start-time-picker').on("dp.change", (e) -> 				
			self.data.start_time( $('#start-time-picker > input').val() )
			$('#end-time-picker').data("DateTimePicker").minDate(e.date);
		);

		$('#end-time-picker').on("dp.change", (e) -> 				
			self.data.end_time( $('#end-time-picker > input').val() )
			$('#start-time-picker').data("DateTimePicker").maxDate(e.date);
		);	

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
			query: self.query()
			start_time: self.data.start_time()
			end_time: self.data.end_time()
			location: self.data.location()

		$.ajax(
			type: 'GET'
			data: data
			dataType: "json"
			url: '/items/search.json'
			success: (data) ->

				firstCollection = 
					id: 0
					name: "Items"
					items: data.items
					collections: []

				data.collections = [
					{
						id: 0,
						name: "Results",
						items: []
						collections: [firstCollection]
					}
				]
				setPaginationData data
				callRegistrations data
		)

	setupTimePickers()
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