# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

homeReady = ->

	map = {}
	geojson = {}
	itemLayers = {}

	setupMap = ->
		map = L.map('store-map').setView(mapInformation.latlng, mapInformation.zoom);
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);
		geojson = L.geoJSON().addTo(map);
		geojson.on 'layeradd', (e) ->
			itemLayers[e.layer.feature.id] = e.layer
		
	clearLayers = ->
		geojson.clearLayers()
		itemLayers = {}	

	updateMap = (data) ->
		clearLayers()

		data.items.forEach (item) ->


			if item.feature.geometry
				currentItem = item
				geojson.addData item.feature
	

		


	if $("body").hasClass("home")

		setupMap()
		searchWidget = new storeViewModels.SearchViewModel()
		collectionsWidget = new storeViewModels.CollectionsViewModel()

		# set callbacks
		searchWidget.registerUpdate (collectionsWidget.updateCollections)
		searchWidget.registerUpdate (updateMap)


		collectionsWidget.setMouseOver (node) ->
			if itemLayers[node.id]
				itemLayers[node.id].setStyle {color: '#FF8833'}
				itemLayers[node.id].bringToFront()
				

		collectionsWidget.setMouseOut (node) ->
			if itemLayers[node.id]
				geojson.resetStyle(itemLayers[node.id])

		collectionsWidget.setClicked (node) ->
			window.location.href = "/items/" + node.id

		# set callback

		ko.applyBindings( searchWidget, document.getElementById("search-widget") )
		searchWidget.setPerPage 3
		ko.applyBindings( collectionsWidget, document.getElementById("collection-widget") )		

$(document).on('turbolinks:load', homeReady);

