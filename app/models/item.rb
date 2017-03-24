class Item < ApplicationRecord
	
	include Featurable
	include Metadatable

	belongs_to :owner, class_name: "User"
	has_and_belongs_to_many :collections
	
	featurable :location, [:name, :start_time, :end_time]
	
	def feature_json
		RGeo::GeoJSON.encode(self.to_feature).to_json		
	end


end
