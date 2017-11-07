class Entity < ApplicationRecord

	belongs_to :owner, class_name: "User"
	belongs_to :item_type
	has_many :metadata_values, dependent: :destroy
	has_many :parent_entities, class_name: "ParentEntity", foreign_key: :parent_entity_id
	has_many :parents, :through => :parent_entities, :source => :child_entity
	accepts_nested_attributes_for :metadata_values, allow_destroy: true
	attr_accessor :children_associations

	def item_type_values
		ItemType.item_type_values(self).first
	end

end
