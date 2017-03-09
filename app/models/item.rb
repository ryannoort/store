class Item < ApplicationRecord
	include Featurable
	belongs_to :owner, class_name: "User"
	has_and_belongs_to_many :collections
	has_and_belongs_to_many :metadata_sets
	# has_one :item_type, as: :itemable
	belongs_to :item_type
	# has_one :item_type
	has_many :metadata_fields, through: :metadata_sets
	# has_many :metadata_values, dependent: :destroy
	has_many :metadata_values, as: :valuable, dependent: :destroy
	accepts_nested_attributes_for :metadata_values, allow_destroy: true
	featurable :location, [:name, :start_time, :end_time]
	
	def feature_json
		RGeo::GeoJSON.encode(self.to_feature).to_json		
	end


end
