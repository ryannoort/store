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
			is_required: ''
			order: 0

		console.log metadata_field
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

		gatherData = ->
			data.metadata_set.name = $('#metadata_set_name').val()
			baseClassName = '.metadata_set_metadata_fields_'
			$('#fields > .field').each (i, item) ->
				console.log(item)
				field = $.extend(true, {}, metadata_field)
				$.each(fields, (i, name) -> 
					thisClass = baseClassName + name
				
					value = $($(item).find(thisClass)).children('[name="'+name+'"]').val()
					field[name] = value
				)
				field.order = i
				data.metadata_set.metadata_fields_attributes.push field

		$('#add_field').click ->
			$('#fields').append($(fieldTemplate).clone(true))

		fieldTemplate = $('#field-template').clone(true)
		fieldTemplate.attr('hidden', false)

$(document).on('turbolinks:load', metadataSetReady);