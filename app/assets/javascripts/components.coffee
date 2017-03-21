ko.components.register 'validate-input',
	viewModel: (params) ->
		this.label = params.label
		this.value = params.value
		
		console.log ''
	template: "<div class=\"form-group\" data-bind='css:{\"has\-error\": value.prevError}'>" +
				"<label class=\"control-label\" data-bind='text: label'></label>" +
				"<input class=\"form-control\" data-bind='value: value, valueUpdate: \"afterkeydown\"' />" +
				"<span data-bind=\"if: value.validationMessage\">" +
				"<span class=\"control-label\" data-bind='html: value.validationMessage()'></span>" +
				"</span>" +
			  "</div>"
