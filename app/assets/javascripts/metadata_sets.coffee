# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

metadataSetReady = ->
	if ($('body').hasClass('metadata_sets') and $('body').hasClass('new'))

		data = 
			metadata_set:
				name: ''
				metadata_fields_attributes: []

		metadata_field =
			name: ""
			field_type: 'text_field'
			hint: ''
			default: ''
			is_required: false
			order: 0

		fields = $.map(metadata_field, (element,index) -> return index)

		$('.remove-field').click (e) ->
			$(e.target).parent().remove()

		$('#save_set').click ->		
			gatherData()
			$.ajax({
				type: 'POST',
				dataType: 'json',
				data: data,
				url: '/metadata_sets.json'
			})

		getInputValue = (input) ->
			console.log input
			if ($(input).is(':checkbox'))	
				console.log "found check"
				return $(input).is ":checked"
			return $(input).val()


		gatherData = ->
			data.metadata_set.name = $('#metadata_set_name').val()
			baseClassName = '.metadata_set_metadata_fields_'
			$('#fields > .field').each (i, item) ->
				field = $.extend(true, {}, metadata_field)
				$.each(fields, (i, name) -> 
					thisClass = baseClassName + name
					input = $($(item).find(thisClass)).children('[name="'+name+'"]')[0]
					field[name] = getInputValue(input)
				)
				field.order = i
				console.log(field)
				data.metadata_set.metadata_fields_attributes.push field

		$('#add_field').click ->
			$('#fields').append($(fieldTemplate).clone(true))

		fieldTemplate = $('#field-template').clone(true)
		fieldTemplate.attr('hidden', false)

$(document).on('turbolinks:load', metadataSetReady);