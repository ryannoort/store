# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

itemTypeReady = ->
	if ($('body').hasClass('item_types') and $('body').hasClass('new'))

		data =
			item_type:
				name: ''
				metadata_set_ids: []

		# create behaviour for add button
		$('#add_set').click ->
			$('#sets').append($(setTemplate).clone(true))

		$('.remove-set').click (e) ->
			$(e.target).parent().remove()

		$('#save_item_type').click ->
			gatherData()

			$.ajax
				type: 'POST'
				dataType: 'json'
				data: data
				url: '/item_types.json'

		gatherData = ->
			data.item_type.name = $("#item_type_name").val()
			$('#sets > .set > div > [name="item_type_metadata_set"]').each (i, metadata_set) ->
				data.item_type.metadata_set_ids.push $(metadata_set).val()


		setTemplate = $('#set-template').clone(true)
		setTemplate.attr('hidden', false)

$(document).on('turbolinks:load', itemTypeReady);	

