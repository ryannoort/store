class Collection < ApplicationRecord
	belongs_to :form
	belongs_to :owner, class_name: "User"
	belongs_to :parent_collection, class_name: "Collection"
	has_many :collections, :foreign_key => "parent_collection_id"
	has_and_belongs_to_many :items
end
