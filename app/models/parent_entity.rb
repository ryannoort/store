class ParentEntity < ApplicationRecord
	belongs_to :child_entity, class_name: "Entity"
	belongs_to :parent_entity, class_name: "Entity"
end
