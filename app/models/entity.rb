class Entity < ApplicationRecord

	include Metadatable

	belongs_to :owner, class_name: "User"
	has_one :item_type
	
end
