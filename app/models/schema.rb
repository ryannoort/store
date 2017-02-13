# class Schema < ApplicationRecord
# 	has_many :items

# 	@form_definition = nil
# 	def get_form_definition
# 		# TODO: Create static cache for definitions

# 		if(@form_definition == nil)
# 			xml_data = MultiXml.parse(self.xml_content)["Schema"]
# 			@form_definition = FormDefinition.new(self, xml_data)
# 		end

# 		return @form_definition
# 	end
# end