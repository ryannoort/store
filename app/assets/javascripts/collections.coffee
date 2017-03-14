collectionsReady = ->
	if ($("body").hasClass("collections") and ($("body").hasClass("new") or $("body").hasClass("edit")))

		CollectionViewModel = ->
			self = this

			self.itemTypes = ko.observableArray itemTypes
			self.itemType = ko.observable self.itemTypes[0]
			$.each self.itemTypes(), (i, type) ->
				$.each type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field['value'] = ""

			self.data = 
				name: ko.observable "Collection test"
				item_ids: ko.observable "1"
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

			setAllDataValues = (data) ->
				self.data.name data.name
				self.data.item_ids  data.item_ids.join ','
				self.data.collection_ids data.collection_ids
				self.data.item_type_id data.item_type_id
				$.each self.itemTypes(), (i, type) ->
					if type.id == data.item_type.id
						self.itemTypes.replace(type, data.item_type)
						self.itemType data.item_type
			
			getExtraData = ->
				self.data.item_ids = self.data.item_ids().split(",")
				# self.data.collections = self.data.collection_ids().split(",")
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

			console.log ""

		
		ko.applyBindings( new CollectionViewModel() )

$(document).on('turbolinks:load', collectionsReady);