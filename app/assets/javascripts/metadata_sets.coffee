# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

metadataSetReady = ->

	if $('body').hasClass('metadata_sets') and ($('body').hasClass('new') or $('body').hasClass('edit'))

		MetadataField = ->
			self = this
			self.name = ko.observable('').extend required: ''
			self.field_type = ''
			self.hint = ''
			self.default = ''
			self.is_required = false

		MetadataSetViewModel = ->
			self = this

			self.data = 
				name: ko.observable('').extend required: "" 
				# name: ko.observable('')
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
						console.log "test"
						self.data.name data.name
						$.each(data.metadata_fields, (i,val) ->
							val.name = ko.observable(val.name).extend required: ''
						)
						self.data.metadata_fields_attributes(data.metadata_fields)
				)

			isFormValid = ->

				if self.data.name.hasError()
					return false

				isValid = true
				$.each(self.data.metadata_fields_attributes(), (i, val) ->
					if val.name.hasError()
						isValid = false
						return false
				)

				return isValid


			self.addMetadataField = ->
				self.data.metadata_fields_attributes.push new MetadataField()

			self.removeField = (field) -> 
				self.data.metadata_fields_attributes.destroy field

			self.saveMetadataSet = ->
				# check if name is not ''
				if isFormValid()
					$.ajax
						type: method
						dataType: 'json'
						data: ko.toJS(metadata_set: self.data)
						url: '/metadata_sets' + addId + '.json'
						success: (resp) ->
							window.location.href = resp.url
				else
					alertify.notify("Form is not valid", "error")
				

			console.log ''
		
		ko.applyBindings( new MetadataSetViewModel() )

$(document).on('turbolinks:load', metadataSetReady);