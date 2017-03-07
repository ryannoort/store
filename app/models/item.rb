class Item < ApplicationRecord
	include Featurable
	# has_one :form
	belongs_to :owner, class_name: "User"
	# belongs_to :metadata_set
	has_and_belongs_to_many :collections
	has_and_belongs_to_many :metadata_sets
	# has_many :fields, dependent: :destroy, as: :fieldable
	belongs_to :item_type
	has_many :metadata_fields, through: :metadata_sets
	has_many :metadata_values, dependent: :destroy
	accepts_nested_attributes_for :metadata_values, allow_destroy: true
	featurable :location, [:name, :start_time, :end_time]
	
	def feature_json
		RGeo::GeoJSON.encode(self.to_feature).to_json		
	end

end
