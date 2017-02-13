# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

metadataSetReady = ->
	if ($("body").hasClass("metadata_sets") 

		sets = $.ajax({
			dataType: 'json',
			url: '/metadata_sets.json',
			success: setsFetched
			})

		setsFetched = ->
			console.log(sets)


$(document).ready(itemsReady);
$(document).on('turbolinks:load', itemsReady);