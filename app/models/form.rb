class Form < ApplicationRecord
	belongs_to :schema
	has_many :items
end
