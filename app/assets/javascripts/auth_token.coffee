authReady = ->
	args =
		beforeSend: (request) -> request.setRequestHeader("X-CSRF-Token",  $('meta[name="csrf-token"]').attr('content') ),
	$.ajaxSetup(args)

# $(document).ready(authReady)
$(document).on('turbolinks:load', authReady);