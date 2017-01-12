class Item < ApplicationRecord
	belongs_to :form
	belings_to :owner, class_name: "User"
end
