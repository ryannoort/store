class Field < ApplicationRecord
	belongs_to :form
	
	enum type: [:text_field, :text_area, :file, :image, :email, :url, :number]
end
