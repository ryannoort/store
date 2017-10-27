class Collection < Entity

	has_many :child_entities, class_name: "ParentEntity", foreign_key: :child_entity_id
	has_many :children, :through => :child_entities, :source => :parent_entity

end
