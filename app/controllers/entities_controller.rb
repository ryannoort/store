class EntitiesController < ApplicationController

	def index	
		@entities = Entity.where(is_public: true).paginate(page: params[:page], per_page: 10).select(:id, :name, :type)
		respond_to do |format|			
			# format.json {render json: @entities, status: :ok, root: true}
			format.json {render json: @entities, status: :ok, root: true}
		end
	end


end
