# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

itemTypeReady = ->
	if ($('body').hasClass('item_types') and $('body').hasClass('new'))

		# get all sets and fill select
		# setTemplate = ''

		# $.ajax(
		# 	type: 'GET'
		# 	dataType: 'json'
		# 	url: '/metadata_sets.json'
		# 	async: false
		# 	success: (sets) ->
		# 		$.each(sets, (i, set) ->
		# 			test = $('.set-select').append($('<option>',
		# 				value: set.id
		# 				text: set.id
		# 			))
		# 			setTemplate = $('#set-template').clone(true)
		# 			setTemplate.attr('hidden', false)
		# 		)
		# )

		# setTemplate = $('#set-template').clone(true)
		# setTemplate.attr('hidden', false)



		data =
			item_type:
				name: ''
				metadata_sets_ids: []

		# create behaviour for add button
		$('#add_set').click ->
			$('#sets').append($(setTemplate).clone(true))

		$('.remove-set').click (e) ->
			$(e.target).parent().remove()

		$('#save_item_type').click ->
			gatherData()
			console.log(data)
			$.ajax
				type: 'POST'
				dataType: 'json'
				data: data
				url: '/item_types.json'

		gatherData = ->
			data.item_type.name = $("#item_type_name").val()
			$('#sets > .set > div > [name="item_type_metadata_set"]').each (i, metadata_set) ->
				data.item_type.metadata_sets_ids.push {id: $(metadata_set).val() }
				# console.log $(metadata_set).val()


		setTemplate = $('#set-template').clone(true)
		setTemplate.attr('hidden', false)

$(document).on('turbolinks:load', itemTypeReady);	

# accepts_nested_attributes_for :exercise_sets, :reject_if => lambda { |a| a[:exercise_id].blank? }, :allow_destroy => true
