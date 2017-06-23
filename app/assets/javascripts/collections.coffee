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

$(document).on('turbolinks:load', collectionsReady);