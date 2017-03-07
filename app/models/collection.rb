class Collection < ApplicationRecord
	belongs_to :owner, class_name: "User"
	has_many :collections
	has_and_belongs_to_many :items
end
