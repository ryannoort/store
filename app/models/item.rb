class Item < ApplicationRecord
	has_one :form
	belongs_to :owner, class_name: "User"
	has_and_belongs_to_many :collections

	accepts_nested_attributes_for :form
end
