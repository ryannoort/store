# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

itemTypeReady = ->
	if $('body').hasClass('item_types') and ($('body').hasClass('new') or $('body').hasClass('edit'))

		MetadataSet = ->
			self = this
			self.id = ''

		ItemTypeViewModel = ->
			self = this			


			self.data =
				name: ko.observable ''
				metadata_sets_ids: ko.observableArray []

			addId = ''
			method = 'POST'

			if $('body').hasClass('edit')
				addId = '/' + itemTypeId
				method = 'PUT'
				$.ajax(
					type: 'GET'
					dataType: 'json'
					url: '/item_types/' + itemTypeId + 'json'
					success: (data) ->
						console.log data
						self.data.name(data.name)
						self.data.metadata_sets_ids(data.metadata_sets)
				)

			self.addMetadataSet = ->
				self.data.metadata_sets_ids.push new MetadataSet()

			self.removeMetadataSet = (metadata_set) ->
				self.data.metadata_sets_ids.destroy metadata_set

			self.saveItemType = ->
				$.ajax(
					type: method
					dataType: 'json'
					data: ko.toJS(item_type: self.data)
					url: '/item_types' + addId + '.json'
				)

			console.log ''

		ko.applyBindings( new ItemTypeViewModel() )

		# # create behaviour for add button
		# $('#add_set').click ->
		# 	$('#sets').append($(setTemplate).clone(true))

		# $('.remove-set').click (e) ->
		# 	$(e.target).parent().remove()

		# $('#save_item_type').click ->
		# 	gatherData()

		# 	$.ajax
		# 		type: 'POST'
		# 		dataType: 'json'
		# 		data: data
		# 		url: '/item_types.json'

		# gatherData = ->
		# 	data.item_type.name = $("#item_type_name").val()
		# 	$('#sets > .set > div > [name="item_type_metadata_set"]').each (i, metadata_set) ->
		# 		data.item_type.metadata_set_ids.push $(metadata_set).val()


		# setTemplate = $('#set-template').clone(true)
		# setTemplate.attr('hidden', false)

$(document).on('turbolinks:load', itemTypeReady);	

