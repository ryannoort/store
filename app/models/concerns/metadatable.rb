# module Metadatable
# 	extend ActiveSupport::Concern

# 	included do
# 		belongs_to :item_type
# 		has_many :metadata_values, as: :valuable, dependent: :destroy
# 		accepts_nested_attributes_for :metadata_values, allow_destroy: true
# 	end

# 	def item_type_values
# 		ItemType.item_type_values(self).first
# 	end

# end