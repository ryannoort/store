
extendersNameSpace =
	flattenBooleanHash : (h) ->
		for key of h 
			if h[key]
				return false
		return true

	addValidationParameters : (target) ->
		target.hasError ?= ko.observable()
		target.prevError ?= ko.observable(false)
		target.validationMessage ?= ko.observable()

	setValidationMessage : (target, message) ->
		if target.hasError()
			target.validationMessage message
		else
			target.validationMessage ""

	initalValidation: (validate, target) -> 
		validate target() 
		target.prevError false
		target.subscribe(validate)

# XXX Refactor

ko.extenders.required = (target, overrideMessage) ->

	extendersNameSpace.addValidationParameters target
	message = overrideMessage || '<i class="fa fa-asterisk" aria-hidden="true"></i> <i>This field is required</i>'

	validate = (newValue) ->
		target.hasError(!newValue);
		target.prevError target.hasError()

	
	target.validationMessage(message)
	extendersNameSpace.initalValidation validate, target
	return target


ko.extenders.numeric = (target, overrideMessage) ->
	extendersNameSpace.addValidationParameters target
	message = overrideMessage || '<span>This field needs a numeric value</span>'

	isNumber = new RegExp "^\\d+(\\.\\d+)?$"

	validate = (newValue) ->
		target.hasError( ! isNumber.test newValue )
		target.prevError target.hasError()
	
	target.validationMessage(message)
	extendersNameSpace.initalValidation validate, target

	return target

ko.extenders.email = (target, overrideMessage) ->
	extendersNameSpace.addValidationParameters target
	message = overrideMessage || '<span>This field should be an email address</span>'

	isEmail = new RegExp /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

	validate = (newValue) ->
		target.hasError( ! isEmail.test newValue )
		target.prevError target.hasError()
	
	target.validationMessage(message)
	extendersNameSpace.initalValidation validate, target
	
	return target