# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

homeReady = ->

	map = {}
	geojson = {}
	itemLayers = {}

	setupMap = ->
		map = L.map('store-map').setView([53.525283, -113.525612], 14);
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);
		geojson = L.geoJSON().addTo(map);
		geojson.on 'layeradd', (e) ->
			itemLayers[e.layer.feature.id] = e.layer

			# itemLayers[e.layer.feature.id] e.layer
			# console.log e.layer
			# currentItem.layer = e.layer
			# e.layer
		# geoJsonLayer.on('layeradd', (e) ->
		# 	console.log e.layer
  #  		# do something with e.layer
		
	clearLayers = ->
		geojson.clearLayers()
		itemLayers = {}	

	updateMap = (data) ->
		# show orphan items

		# featureGroup = L.featureGroup().addTo(map);
		# geojsonLayer = L.geoJSON(feature)
		# addNonGroupLayers(geojsonLayer, featureGroup)
		# if geojsonLayer.getBounds().isValid()
		# 	map.fitBounds(geojsonLayer.getBounds());

		# var myLayer = L.geoJSON().addTo(map);
		# myLayer.addData(geojsonFeature);
		
		# geojson.removeLayer
		# map.removeLayer(geojson)
		# map.addLayer geojson
		# map.clea
		clearLayers()

		data.items.forEach (item) ->
			# console.log item.name
			# console.log item.start_time
			# console.log item.end_time
			# console.log item.location

			if item.feature.geometry
				currentItem = item
				geojson.addData item.feature
	
		# geojson.eachLayer (layer) ->
		# 	layer.setStyle {color: '#'+Math.floor(Math.random()*16777215).toString(16)}

		# geojson.eachLayer (layer) ->
		# 	geojson.resetStyle layer
		# geojson.resetStyle(geojson)

# 		geojson_layer.eachLayer(function (layer) {  
#   if(layer.feature.properties.NAME == 'feature 1') {    
#     layer.setStyle({fillColor :'blue'}) 
#   }
# });

		# geojson.setStyle({color: "#FF0000"});
		# geojson.eachLayer
		


	if $("body").hasClass("home")

		setupMap()
		searchWidget = new storeViewModels.SearchViewModel()
		collectionsWidget = new storeViewModels.CollectionsViewModel()

		# set callbacks
		searchWidget.registerUpdate (collectionsWidget.updateCollections)
		searchWidget.registerUpdate (updateMap)

		collectionsWidget.mouseOver = (node) ->
			if itemLayers[node.id]
				itemLayers[node.id].setStyle {color: '#FF8833'}
				itemLayers[node.id].bringToFront()
				
			# console.log itemLayers[node.id]

		collectionsWidget.mouseOut = (node) ->
			if itemLayers[node.id]
				geojson.resetStyle(itemLayers[node.id])
			# console.log itemLayers[node.id]

		

		# set callback

		ko.applyBindings( searchWidget, document.getElementById("search-widget") )
		ko.applyBindings( collectionsWidget, document.getElementById("collection-widget") )		

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
