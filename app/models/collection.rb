class Collection < Entity

	has_many :child_entities, class_name: "ParentEntity", foreign_key: :child_entity_id
	has_many :children, -> {order 'parent_entities.order'}, :through => :child_entities, :source => :parent_entity	
	attr_accessor :children_associations
	
	scope :without_parents, -> {
		left_outer_joins(:parent_entities).where(parent_entities: {id: nil})
	}

end

