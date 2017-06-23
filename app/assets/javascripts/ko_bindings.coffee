
bindingsReady = ->

	ko.bindingHandlers.summernote =
		init: (element, valueAccessor, allBindingsAccessor) ->

			value = valueAccessor()

			$(element).summernote("code", value());

			$(element).on('summernote.blur', (we, e) -> 
				value(e.currentTarget.innerHTML)
			)

$(document).on('turbolinks:load', bindingsReady);