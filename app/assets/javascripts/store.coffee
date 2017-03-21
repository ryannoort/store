
window.storeHelpers = {}

storeReady = ->
	window.storeHelpers = {
		createValidatableField : (field, value) ->
			observableField = ko.observable value
			if field.is_required
				observableField.extend required: ""
			if field.field_type == "email"
				observableField.extend email: ""
			if field.field_type == "number"
				observableField.extend numeric: ""
			return observableField
	}

$(document).on('turbolinks:load', storeReady);