class Schema < ApplicationRecord
	has_many :forms
end

class CollectionSchema < Schema
end

class ItemSchema < Schema
end
