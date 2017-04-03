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

		# map = L.map('store-map').setView([53.525283, -113.525612], 14);
		map = L.map('store-map').setView(mapInformation.latlng, mapInformation.zoom);
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
		if $("body").hasClass("edit")
			
			geojsonLayer = L.geoJSON(feature)
			addNonGroupLayers(geojsonLayer, featureGroup)
			if geojsonLayer.getBounds().isValid()
				map.fitBounds(geojsonLayer.getBounds());
				disableDrawing()
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

			self.itemTypes = ko.observableArray itemTypes
			self.itemType = ko.observable(self.itemTypes[0])
			$.each self.itemTypes(), (i, type) ->
				$.each type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field['value'] = storeHelpers.createValidatableField(field, field.default)

			self.data = 
				name: ko.observable("").extend required: ""
				start_time: ko.observable ""
				end_time: ko.observable ""
				is_public: ko.observable true
			
			addId = ''
			method = 'POST'
			if $("body").hasClass("edit")
				addId = '/' + itemId
				method = 'PUT'
				$.ajax(
					type: "GET"
					dataType: "json"
					url: '/items' + addId + '.json'
					success: (data) ->
						setAllDataValues data
				)
		
			# setupLinkedTimePicker('#start-time-picker', '#end-time-picker')				
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

			setAllDataValues = (data) ->
				
				self.data.name data.name
				self.data.start_time data.start_time
				self.data.end_time data.end_time
				self.data.is_public data.is_public

				$.each data.item_type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field.value = storeHelpers.createValidatableField(field, field.value)
						console.log field.value.hasError

				$.each self.itemTypes(), (i, type) ->
					if type.id == data.item_type.id
						self.itemTypes.replace(type, data.item_type)
						self.itemType data.item_type

				
			getExtraData = ->
				self.data.location = $("#item_location").val()
				self.data.item_type_id = self.itemType().id
				
				self.data.metadata_values_attributes = []
				$.each self.itemType().metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						self.data.metadata_values_attributes.push(
							metadata_field_id: field.id
							value: field.value()
						)

			isFormValid = ->
				if self.data.name.hasError()
					return false
				
				isValid = true
				$.each self.itemType().metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->						
						console.log field.name
						if field.value.hasError()
							console.log field
							isValid = false
							return false
				return isValid

			self.saveItem = ->
				getExtraData()
				
				data = 
					item: self.data

				# ajax call
				if isFormValid()					
					$.ajax
						type: method
						dataType: 'json'
						data: data
						url: '/items' + addId + '.json'
						success: (resp) ->
							window.location.href = resp.url
				else 
					alertify.notify("Form is not valid", "error")
			

			console.log ""


		ko.applyBindings( new MetadataTypeViewModel() )

	if ($("body").hasClass("items") and $("body").hasClass("show"))
		# XXX Change set view to parameter specified on rail side
		# map = L.map('store-map').setView([53.525283, -113.525612], 14);
		map = L.map('store-map').setView(mapInformation.latlng, mapInformation.zoom);
		L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
		}).addTo(map);

		geojsonLayer = L.geoJSON(feature).addTo(map);
		if geojsonLayer.getBounds().isValid()
			map.fitBounds(geojsonLayer.getBounds());


$(document).on('turbolinks:load', itemsReady);

