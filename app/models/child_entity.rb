class ChildEntity < ApplicationRecord
	belongs_to :entity, class_name: "Entity"
	belongs_to :child_entity, class_name: "Entity"
end
