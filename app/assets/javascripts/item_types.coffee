# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

itemTypeReady = ->
	if $('body').hasClass('item_types') and ($('body').hasClass('new') or $('body').hasClass('edit'))

		MetadataSet = (id = "", name = "") ->
			self = this
			self.id = id
			self.name = name

		ItemTypeViewModel = ->
			self = this			


			self.data =
				name: ko.observable("").extend required: ""
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

			isFormValid = ->
				if self.data.name.hasError()
					return false
				return true

			self.addMetadataSet = ->
				self.data.metadata_sets_ids.push new MetadataSet()

			# Change to use destroy instead of removing metadata_set
			self.removeMetadataSet = (metadata_set) ->
				console.log metadata_set
				# self.data.metadata_sets_ids.destroy metadata_set
				self.data.metadata_sets_ids.remove metadata_set
				console.log self.data.metadata_sets_ids()

			self.saveItemType = ->
				if isFormValid()
					$.ajax
						type: method
						dataType: 'json'
						data: ko.toJS(item_type: self.data)
						url: '/item_types' + addId + '.json'
						success: (resp) ->
							window.location.href = resp.url
				else
					alertify.notify("Form is not valid", "error")
				
			console.log ''

		ko.applyBindings( new ItemTypeViewModel() )

$(document).on('turbolinks:load', itemTypeReady);	
