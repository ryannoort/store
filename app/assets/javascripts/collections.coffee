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
				item_ids: ko.observable ""
				collection_ids: ko.observable ""
				item_type_id: ko.observable ""

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

			self.getItemsIds =() ->
				return self.data.item_ids().split(',')

			setAllDataValues = (data) ->
				self.data.name data.name
				self.data.item_ids  data.item_ids.join ','
				self.data.collection_ids data.collection_ids
				self.data.item_type_id data.item_type_id
				self.updateSelected( data.item_ids, data.collection_ids)

				$.each data.item_type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field.value = storeHelpers.createValidatableField(field, field.value)

				$.each self.itemTypes(), (i, type) ->
					if type.id == data.item_type.id
						self.itemTypes.replace(type, data.item_type)
						self.itemType data.item_type
			
			getExtraData = ->
				self.data.item_ids = collectionsWidget.getSelected().items #self.data.item_ids().split(",")
				#self.data.collection_ids = self.data.collection_ids().split(",")
				self.data.item_type_id = self.itemType().id
				self.data.metadata_values_attributes = []
				$.each self.itemType().metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						self.data.metadata_values_attributes.push(
							metadata_field_id: field.id
							value: field.value
						)

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

			# XXX Fix this. Should be turned into a registered callback if more are needed
			self.updateSelected = (data) -> {}

			console.log ""

		
		collectionsWidget = new storeViewModels.CollectionsViewModel()
		collectionViewModel = new CollectionViewModel()
		collectionsWidget.itemsSelectable = true
		collectionViewModel.updateSelected = collectionsWidget.updateSelected
		searchWidget = new storeViewModels.SearchViewModel()
		searchWidget.registerUpdate (collectionsWidget.updateCollections)

		ko.applyBindings( searchWidget, document.getElementById("search-widget") )
		ko.applyBindings( collectionsWidget, document.getElementById("collection-widget") )
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
			self.template = item.type + '-template'
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
			self.template = collection.type + '-template'
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
		
		# XXX fetch this id from back-end
		initialCollection =
			id: 1
			name: 'collection'

		collectionParent = new CollectionViewModel(initialCollection)
				
		collectionParent.setItemCallback updateMap
		collectionParent.fetch(collectionParent.fetchChildren)
		

		ko.applyBindings(collectionParent, document.getElementById('collection-parent'))

		return

$(document).on('turbolinks:load', collectionsReady);