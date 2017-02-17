# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/

# metadataSetReady = ->
# 	if ($('body').hasClass('metadata_sets') and $('body').hasClass('new'))
# 		# # data = { 
# 		# # 	metadata_set: {
# 		# # 		name: 'new set'
# 		# # 		metadata_fields_attributes: [
# 		# # 			{
# 		# # 				name: 'test field 1'
# 		# # 				field_type: 'text_field'
# 		# # 			},
# 		# # 			{
# 		# # 				name: 'test field 2'
# 		# # 				field_type: 'text_field'
# 		# # 			}
# 		# # 		]
# 		# # 	}
# 		# # }

# 		# data = 
# 		# 	metadata_set:
# 		# 		name: ''
# 		# 		metadata_fields_attributes: []

# 		# metadata_field =
# 		# 	name: ""
# 		# 	field_type: 'text_field'
# 		# 	hint: ''
# 		# 	default: ''
# 		# 	is_required: false

# 		# $('.remove-field').click (e) ->
# 		# 	$(e.target).parent().remove()


# 		# $('#update_set').click ->		
# 		# 	gatherData()	
# 		# 	# set = $.ajax({
# 		# 	# 	type: 'POST',
# 		# 	# 	dataType: 'json',
# 		# 	# 	data: data,
# 		# 	# 	url: '/metadata_sets.json'
# 		# 	# })

# 		# gatherData = ->
# 		# 	data.metadata_set.namne = $('#metadata_set_name').val()
# 		# 	# field = $.extend(true, {}, metadataField)
# 		# 	$('.field').each ->
# 		# 		$(this).children().each ->
# 		# 			console.log(this)

# 		# field_clear = $('#field-clear').clone(true)
# 		# field_clear.attr('hidden', false)

# 		# $('#add_field').click ->
# 		# 	$('.fields').append($(field_clear).clone(true));

# 		# AppViewModel = ->
# 		# 	this.firstName = "Bert"
# 		# 	this.lastName = "bergniton"
# 		# ko.applyBindings(new AppViewModel());			


# 		MetadataField = ->
# 			self = this

# 		MetadataSetViewModel = ->
# 			self = this
# 			self.data =
# 				metadata_set:
# 					name: ko.observable('test')
# 					metadata_fields_attributes: ko.observableArray()
			
# 			self.addField = ->
# 				self.data.metadata_set.metadata_fields_attributes.push(new MetadataField())

# 			console.log("")
		
# 		ko.applyBindings(new MetadataSetViewModel());				

# $(document).on('turbolinks:load', metadataSetReady);