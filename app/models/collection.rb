class Collection < Entity

	has_many :child_entities, class_name: "ParentEntity", foreign_key: :child_entity_id
	has_many :children, -> {order 'parent_entities.order'}, :through => :child_entities, :source => :parent_entity	
	attr_accessor :children_associations

	scope :without_parents, -> {
		left_outer_joins(:parent_entities).where(parent_entities: {id: nil})
	}

	# def update_children(parameters)
	# 	self.children.clear
	# 	parameters['children_associations'].each do |child|
	# 		parent_association = new ParentEntity()
	# 		parent_association.parent = self
	# 		parent_association.child = Entity.find child.id
	# 		parent_association.order = child.order
	# 		parent_association.save
	# 	end
	# end
end

