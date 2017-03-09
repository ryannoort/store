collectionsReady = ->
	if ($("body").hasClass("collections") and ($("body").hasClass("new") or $("body").hasClass("edit")))

		CollectionViewModel = ->
			self = this
			self.data = 
				name: "1"
				item_ids: "1,2"
				collection_ids: ""
				item_type_id: ""

			self.itemTypes = itemTypes
			self.itemType = ko.observable(self.itemTypes[0])
			$.each self.itemTypes, (i, type) ->
				$.each type.metadata_sets, (j, set) ->
					$.each set.metadata_fields, (k, field) ->
						field['value'] = ""
			
			getExtraData = ->
				self.data.item_ids = self.data.item_ids.split(",")
				self.data.collections = self.data.collection_ids.split(",")
				self.data.item_type_id = self.itemType().id
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
					type: 'POST'
					dataType: 'json'
					data: data
					url: '/collections.json'

			console.log ""

		
		ko.applyBindings( new CollectionViewModel() )

$(document).on('turbolinks:load', collectionsReady);