# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

itemTypeReady = ->
	if $('body').hasClass('item_types') and ($('body').hasClass('new') or $('body').hasClass('edit'))

		MetadataSet = ->
			self = this
			self.id = ''

		ItemTypeViewModel = ->
			self = this			


			self.data =
				name: ko.observable ''
				metadata_sets_ids: ko.observableArray []

			addId = ''
			method = 'POST'

			if $('body').hasClass('edit')
				addId = '/' + itemTypeId
				method = 'PUT'
				$.ajax(
					type: 'GET'
					dataType: 'json'
					url: '/item_types/' + itemTypeId + 'json'
					success: (data) ->
						self.data.name(data.name)
						self.data.metadata_sets_ids(data.metadata_sets)
				)

			self.addMetadataSet = ->
				self.data.metadata_sets_ids.push new MetadataSet()

			self.removeMetadataSet = (metadata_set) ->
				self.data.metadata_sets_ids.destroy metadata_set

			self.saveItemType = ->
				$.ajax
					type: method
					dataType: 'json'
					data: ko.toJS(item_type: self.data)
					url: '/item_types' + addId + '.json'
					success: (resp) ->
						window.location.href = resp.url
				

			console.log ''

		ko.applyBindings( new ItemTypeViewModel() )

$(document).on('turbolinks:load', itemTypeReady);	

