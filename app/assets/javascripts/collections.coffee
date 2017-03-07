collectionsReady = ->
	if ($("body").hasClass("collections") and ($("body").hasClass("new") or $("body").hasClass("edit")))

		CollectionViewModel = ->
			self = this
			self.data = 
				name: ""
				item_ids: "1"
				collection_ids: "13"
			
			self.saveCollection = ->
				# self.data.item_ids = self.data.item_ids.split(",")
				# self.data.collections = self.data.collections.split(",")

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