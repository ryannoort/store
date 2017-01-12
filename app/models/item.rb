class Item < ApplicationRecord
	belongs_to :form
	belongs_to :owner, class_name: "User"
	has_and_belongs_to_many :collections
end
