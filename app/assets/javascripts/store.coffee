
window.storeHelpers = {}

storeReady = ->
	window.storeHelpers = {
		createValidatableField : (field, value) ->
			observableField = ko.observable value
			if field.is_required
				observableField.extend required: ""

			switch field.field_type
				when "email" then observableField.extend email: ""
				when "number" then observableField.extend number: ""
				else observableField.extend simple: ""

			return observableField
	}

$(document).on('turbolinks:load', storeReady);