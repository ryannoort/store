# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

itemsReady = ->
	if $("body").hasClass("items") and ($("body").hasClass("new") or $("body").hasClass("edit"))

		enabledButtons = []
		disabledButtons = []

		initializeDrawing = ->
			# initialize polygon, polyline and marker
			enabledButtons.push(document.getElementsByClassName('leaflet-draw-draw-polyline')[0])
			enabledButtons.push(document.getElementsByClassName('leaflet-draw-draw-polygon')[0])
			enabledButtons.push(document.getElementsByClassName('leaflet-draw-draw-marker')[0])

			$.each(enabledButtons, (index, value) ->
				disabledButton = value.cloneNode(true)
				$(disabledButton)
					.addClass("leaflet-disabled")
					.on("click", (e) -> 
						e.preventDefault()
					)
				disabledButtons.push(disabledButton)
			)

		enableDrawing = ->
			$.each(disabledButtons, (index, value) ->
				value.parentNode.replaceChild(enabledButtons[index], value)
			)

		disableDrawing = ->
			$.each(enabledButtons, (index, value) ->
				value.parentNode.replaceChild(disabledButtons[index], value)
			)
			
		setLocationValue = ->
			# Back end saves single geometry per item
			if featureGroup.toGeoJSON().features and featureGroup.toGeoJSON().features[0]
				geometry = featureGroup.toGeoJSON().features[0].geometry
				$("#item_location").val(JSON.stringify(geometry))

		addNonGroupLayers = (sourceLayer, targetGroup) ->
			if (sourceLayer instanceof L.LayerGroup)
				sourceLayer.eachLayer( (layer) -> 
					addNonGroupLayers(layer, targetGroup)
				)
			else
				targetGroup.addLayer(sourceLayer)

		# Create map
		# XXX starting view coordinates to be set on rails

		map = L.map('store-map').setView([53.525283, -113.525612], 14);
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);

		# Configure draw controls
		# XXX Add draw controls only when user has permissions

		drawnItems = new L.FeatureGroup()
		map.addLayer(drawnItems)


		featureGroup = L.featureGroup().addTo(map);

		drawControlOptions =
			draw:
				circle: false
				rectangle: false
			edit:
				featureGroup: featureGroup

		drawControl = new L.Control.Draw(drawControlOptions).addTo(map);

		initializeDrawing()
		# setLocationValue()

		# editing section
		if ($("body").hasClass("edit"))
			disableDrawing()
			geojsonLayer = L.geoJSON(feature)
			addNonGroupLayers(geojsonLayer, featureGroup)
			map.fitBounds(geojsonLayer.getBounds());
			setLocationValue()

		# Update location value catching map events

		map.on(L.Draw.Event.CREATED, (e) ->
			disableDrawing()
			featureGroup.addLayer(e.layer)
			setLocationValue()
		)
			
		map.on(L.Draw.Event.DELETED, (e) ->
			map.removeLayer(drawnItems)
			enableDrawing()
			setLocationValue()
		)

		map.on(L.Draw.Event.EDITED, (e) ->
			setLocationValue()
		)

		# item type management

		MetadataTypeViewModel = ->
			self = this
			# itemTypes is defined on items/_form.html.erb from a ItemType.all call
			self.itemTypes = itemTypes
			self.itemType = ko.observable(self.itemTypes[0])
			$.each self.itemTypes, (i, type) ->
				$.each type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field['value'] = ""

			self.data = 
				name: ko.observable ""
				start_time: ko.observable ""
				end_time: ko.observable ""
				is_public: ko.observable true
			

			if $("body").hasClass("edit")
				$.ajax(
					type: "GET"
					dataType: "json"
					url: '/items/5.json'
					success: (data) ->
						setAllDataValues(data)						
				)
						
			
			setAllDataValues = (data) ->
				self.data.name(data.name)
				self.data.start_time(data.start_time)
				self.data.end_time(data.end_time)
				self.data.is_public(data.is_public)

				
			getExtraData = ->
				self.data.location = $("#item_location").val()
				self.data.item_type_id = self.itemType().id
				self.data.metadata_values_attributes = []
				$.each self.itemType().metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						self.data.metadata_values_attributes.push(
							metadata_field_id: field.id
							value: field.value
						)

			self.saveItem = ->
				getExtraData()
				
				data = 
					item: self.data

				# ajax call
				$.ajax
					type: 'POST'
					dataType: 'json'
					data: data
					url: '/items.json'

			console.log ""


		ko.applyBindings( new MetadataTypeViewModel() )

	if ($("body").hasClass("items") and $("body").hasClass("show"))
		map = L.map('store-map').setView([53.525283, -113.525612], 14);
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);

		geojsonLayer = L.geoJSON(feature).addTo(map);
		map.fitBounds(geojsonLayer.getBounds());



#$(document).ready(itemsReady);
$(document).on('turbolinks:load', itemsReady);

