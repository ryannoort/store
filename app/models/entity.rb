class Entity < ApplicationRecord

	# include Metadatable

	belongs_to :owner, class_name: "User"
	belongs_to :item_type
	has_many :metadata_values, dependent: :destroy
	accepts_nested_attributes_for :metadata_values, allow_destroy: true


	def item_type_values
		ItemType.item_type_values(self).first
	end



end
