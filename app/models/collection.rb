 class Collection < Entity
 	
 	# include Metadatable

	# belongs_to :owner, class_name: "User"
	# has_many :collections
	# has_and_belongs_to_many :items

	has_many :child_entities, class_name: "ParentEntity", foreign_key: :child_entity_id
	# has_many :children, through: :child_entities, foreign_key: :child_entity_id, source: :entity
	has_many :children, :through => :child_entities, :source => :parent_entity
end
