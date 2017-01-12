class Form < ApplicationRecord
	belongs_to :schema
	has_one :item
	has_one :collection
end
