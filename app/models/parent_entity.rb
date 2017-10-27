class ParentEntity < ApplicationRecord
	belongs_to :entity, class_name: "Entity"
	belongs_to :parent_entity, class_name: "Entity"
end
