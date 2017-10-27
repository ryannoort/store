class Item < Entity
	
	include Featurable
	featurable :location, [:name, :start_time, :end_time]
	
	def feature_to_json
		RGeo::GeoJSON.encode(self.to_feature).to_json		
	end

	def feature_as_json
		RGeo::GeoJSON.encode(self.to_feature).as_json		
	end


end
