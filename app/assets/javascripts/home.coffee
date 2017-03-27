# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

	setupMap = ->
		map = L.map('store-map').setView([53.525283, -113.525612], 14);
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);


	if $("body").hasClass("home")

		setupMap()

		collectionsWidget = new storeViewModels.CollectionsViewModel()
		# set callbacks

		searchWidget = new storeViewModels.SearchViewModel()
		searchWidget.registerUpdate (collectionsWidget.updateCollections)
		# set callback

		ko.applyBindings( collectionsWidget, document.getElementById("collection-widget") )
		ko.applyBindings( searchWidget, document.getElementById("search-widget") )

$(document).on('turbolinks:load', ready);


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
