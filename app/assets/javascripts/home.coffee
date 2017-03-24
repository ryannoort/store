# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

homeReady = ->
	if $("body").hasClass("home")

		HomeViewModel = ->
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

			fetchPage()

			console.log ""
			

		ko.applyBindings( new HomeViewModel() )

$(document).on('turbolinks:load', homeReady);


# parseLocatoin = (location) ->
# 	result = ""
# 	latlngs = []
# 	switch location.type
# 		when 'polygon'
# 			result = 'POLYGON '
# 			latlngs = location.layer._latlngs[0]
# 		when 'polyline'
# 			result = 'LINESTRING '
# 			latlngs = location.layer._latlngs
# 		when 'marker'
# 			result = 'POINT '
# 			latlngs = [location.layer._latlng]

# 	result += "(" + (latlng.lat + " " + latlng.lng for latlng in latlngs) + ")"
	
# ready = ->

# 	# Create map
# 	map = L.map('store-map').setView([53.525283, -113.525612], 14);
# 	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
# 	    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
# 	}).addTo(map);


# 	# Configure draw controls
# 	drawnItems = new L.FeatureGroup()
# 	map.addLayer(drawnItems)

# 	options =
# 		draw: {
# 			circle: false,
# 			rectangle: false
# 		}

# 	drawControl = new L.Control.Draw(options)

# 	$("#create-item").click ->
# 		map.addControl(drawControl);
# 		# show name form
# 		# show cancel button
# 		# show save button

# 	location = {}

# 	map.on(L.Draw.Event.CREATED, (e) ->
# 		type = e.layerType;
# 		layer = e.layer;

# 		# pass type and data
# 		# disable controls
# 		location =
# 			type: type
# 			layer: layer
# 		map.addLayer(layer);
# 	)
# 	$("#save_item").click ->
# 		url = "/items.json"

# 		data =			
# 			item: 
# 				name: "name"
# 				location: parseLocatoin(location)
# 				start_time: "start date"
# 				end_time: "end date"
# 				is_public: false
# 			utf8: "✓" 
# 			authenticity_token: $("input[name='authenticity_token']")[0].value
# 		$.ajax({
# 			type: "POST",
# 			url: url,
# 			beforeSend: (request) -> request.setRequestHeader("X-CSRF-Token",  $('meta[name="csrf-token"]').attr('content') ),
# 			data: data,
# 			success: ->
# 				console.log("saved")
# 				console.log(data)
# 				return false
# 			error: ->
# 				console.log("error")
# 				console.log(data)
# 				return false
# 		});

# $(document).ready(ready)
# $(document).on('page:load', ready)
