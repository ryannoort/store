collectionsReady = ->

	if ($("body").hasClass("collections") and ($("body").hasClass("new") or $("body").hasClass("edit")))

		CollectionViewModel = ->
			self = this			
			self.itemTypes = ko.observableArray itemTypes
			self.itemType = ko.observable self.itemTypes[0]			
			$.each self.itemTypes(), (i, type) ->
				$.each type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field['value'] = storeHelpers.createValidatableField(field, field.default)

			self.data = 
				name: ko.observable("").extend required: ""				
				item_type_id: ko.observable ""
				is_public: ko.observable(true)

			method = 'POST'
			addId = ''
			if $("body").hasClass("edit")
				addId = '/' + collectionId
				method = 'PUT'
				$.ajax(
					type: "GET"
					dataType: "json"
					url: '/collections' + addId + '.json'
					success: (data) ->
						setAllDataValues data
				)

			# need to get all entities

			capitalize = (sentence) ->
				first = sentence[0].toUpperCase()
				return first + sentence.slice(1)

			self.entities = ko.observableArray()
			self.children = ko.observableArray()
			$.ajax(
					type: "GET"
					dataType: "json"
					url: '/entities/index.json'
					success: (data) ->
						entities = data.map((x) ->
							type = Object.keys(x)[0];
							result = x[type]
							result.type = capitalize(type)
							result.dragging = ko.observable(false)				
							return result
						)
						self.entities(entities)
				)			

			self.drop = (data) ->
				# console.log data
				# if self.children().length == 0
				# 	self.drop = () -> return
				# 	self.children.push(data)
				# self.children.push(data)
				return 

			self.dragStart = (item) ->
				console.log item
				item.dragging(true)

			self.dragStop = (item) ->
				item.dragging(false)

			self.reorder = (event, dragData, zoneData) ->
				console.log "rer"
				if (dragData != zoneData.item)					
					zoneDataIndex = zoneData.items.indexOf(zoneData.item);
					zoneData.items.remove(dragData);
					console.log zoneData.item
					zoneData.items.splice(zoneDataIndex, 0, dragData);

				#     SortableView.prototype.reorder = function (event, dragData, zoneData) {
    #     if (dragData !== zoneData.item) {
    #         var zoneDataIndex = zoneData.items.indexOf(zoneData.item);
    #         zoneData.items.remove(dragData);
    #         zoneData.items.splice(zoneDataIndex, 0, dragData);
    #     }
    # };

			# drop: function (data, model) {
   #      model.source.remove(data);
   #      model.target.push(data);
   #  }

			setAllDataValues = (data) ->
				console.log data
				self.data.name data.name				
				self.children(data.children)
				
				ko.utils.arrayForEach(self.children(), (child) -> 
					child.dragging = ko.observable(false)
				)
				
				self.data.is_public(data.is_public)

				$.each data.item_type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field.value = storeHelpers.createValidatableField(field, field.value)

				$.each self.itemTypes(), (i, type) ->
					if type.id == data.item_type.id
						self.itemTypes.replace(type, data.item_type)
						self.itemType data.item_type
			
			getExtraData = ->
				self.data.item_type_id = self.itemType().id
				self.data.metadata_values_attributes = []
				self.data.children_associations = []
				$.each self.itemType().metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						self.data.metadata_values_attributes.push(
							metadata_field_id: field.id
							value: field.value
						)
				$.each self.children(), (i, child) ->
					self.data.children_associations.push(
						id: child.id
						order: i
					)

			self.removeEntity = (entity) ->
				self.children.remove(entity)
				console.log "removing"

			self.saveCollection = ->
				getExtraData()

				data =
					collection: self.data				
				
				$.ajax
					type: method
					dataType: 'json'
					data: data
					url: '/collections' + addId + '.json'
					success: (resp) ->						
						window.location.href = resp.url

			return

		
		
		collectionViewModel = new CollectionViewModel()
		ko.applyBindings( collectionViewModel, document.getElementById("collections-form") )

	if ($("body").hasClass("collections") and ($("body").hasClass("show")))
		# vvv copied and modified from home.coffee


		map = {}
		geojson = {}
		itemLayers = {}

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
			feature = data.feature
			clearLayers()

			if feature.geometry
				geojson.addData feature
				if geojson.getBounds().isValid()
					map.fitBounds(geojson.getBounds());

		ItemViewModel = (item) ->
			self = this
			self.id = item.id
			self.name = item.name
			self.type = item.type
			self.feature = ""
			self.fetched = false

			itemCallback = -> return

			self.click = () ->
				itemCallback(self)

			self.setItemCallback = (callback) ->
				itemCallback = callback

			self.fetch = -> 
				if not self.fetched
					$.ajax
						type: 'GET'
						url: '/items/' + self.id + '.json'
						success: (resp) ->		
							self.feature = resp.feature	
							self.fetched = true

			return


		CollectionViewModel = (collection) ->
			self = this
			self.id = collection.id
			self.name = collection.name
			self.type = collection.type
			self.children = ko.observableArray []
			self.isOpen = ko.observable(false)
			fetched = false;

			itemCallback = -> return
			collectionCallback = -> return
			
			processChildren = (children) ->
				ko.utils.arrayForEach(children, (child) -> 
					entity = {}

					if child.type == "Item"
						entity = new ItemViewModel(child)
						entity.setItemCallback itemCallback
					else if child.type == "Collection"
						entity = new CollectionViewModel(child)
						entity.setItemCallback itemCallback
						entity.setCollectionCallback collectionCallback

					self.children.push entity
				)

			self.fetch = (callback = () -> return) ->
				$.ajax
					type: 'GET'
					url: '/collections/' + self.id + '.json'
					success: (resp) ->		
						processChildren(resp.children)
						collectionCallback(self)
						callback()

			self.fetchChildren = ->
				ko.utils.arrayForEach(self.children(), (child) ->
					child.fetch()
				)

			self.click = () ->
				if not fetched
					self.fetchChildren()
					fetched = true

				self.isOpen(not self.isOpen())


			self.setItemCallback = (callback) ->
				itemCallback = callback

			self.setCollectionCallback = (callback) ->
				collectionCallback = callback

			return
		
		# collectionId comes from back end rendered on collection partial
		initialCollection =
			id: collectionId
			name: 'collection'

		collectionParent = new CollectionViewModel(initialCollection)
				
		collectionParent.setItemCallback updateMap
		collectionParent.fetch(collectionParent.fetchChildren)
		

		ko.applyBindings(collectionParent, document.getElementById('collection-parent'))

		return

$(document).on('turbolinks:load', collectionsReady);