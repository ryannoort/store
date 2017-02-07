# class Form < ApplicationRecord
# 	belongs_to :schema
# 	belongs_to :collection, :inverse_of => :form
# 	belongs_to :item, :inverse_of => :form
# 	has_many :fields

# 	accepts_nested_attributes_for :fields

# 	def definition
# 		self.schema.get_form_definition
# 	end
# end
