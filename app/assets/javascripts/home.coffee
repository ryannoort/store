# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/




ready = ->

	# Create map
	map = L.map('store-map').setView([53.525283, -113.525612], 14);
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
	    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
	}).addTo(map);


	# Configure draw controls
	drawnItems = new L.FeatureGroup()
	map.addLayer(drawnItems)

	options =
		draw: {
			circle: false
		}

	drawControl = new L.Control.Draw(options)

	$("#create-item").click ->
		map.addControl(drawControl);
		# show name form
		# show cancel button
		# show save button

	newItem = {}

	map.on(L.Draw.Event.CREATED, (e) ->
		type = e.layerType;
		layer = e.layer;

		# pass type and data
		# disable controls
		console.log(type);
		console.log(layer);
		newItem =
			type: type
			layer: layer
		map.addLayer(layer);
	)


$(document).ready(ready)
$(document).on('page:load', ready)
