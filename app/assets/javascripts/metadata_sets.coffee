# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

metadataSetReady = ->

	if $('body').hasClass('metadata_sets') and ($('body').hasClass('new') or $('body').hasClass('edit'))

		MetadataField = ->
			self = this
			self.name = ''
			self.field_type = ''
			self.hint = ''
			self.default = ''
			self.is_required = false

		MetadataSetViewModel = ->
			self = this

			self.data = 
				name: ko.observable ''
				metadata_fields_attributes: ko.observableArray []			
			
			addId = ''
			method = "POST"
			if $('body').hasClass('edit')
				addId = '/' + metadataSetId
				method = "PUT"
				self.data.id = metadataSetId
				$.ajax(
					type: "GET"
					dataType: "json"
					url: '/metadata_sets' + addId + '.json'
					success: (data) ->
						self.data.name(data.name)
						self.data.metadata_fields_attributes(data.metadata_fields)
				)

			self.addMetadataField = ->
				self.data.metadata_fields_attributes.push new MetadataField()

			self.removeField = (field) -> 
				self.data.metadata_fields_attributes.destroy field

			self.saveMetadataSet = ->
				
				$.ajax
					type: method
					dataType: 'json'
					data: ko.toJS(metadata_set: self.data)
					url: '/metadata_sets' + addId + '.json'
					success: (resp) ->
						window.location.href = resp.url

			console.log ''
		
		ko.applyBindings( new MetadataSetViewModel() )

$(document).on('turbolinks:load', metadataSetReady);