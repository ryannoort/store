class Collection < ApplicationRecord
	belongs_to :owner, class_name: "User"
	has_many :collections
	# has_many :fields, dependent: :destroy, as: :fieldable
	has_and_belongs_to_many :items
end
