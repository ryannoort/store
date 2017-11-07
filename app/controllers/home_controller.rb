class HomeController < ApplicationController
	before_action :set_root_collections, only: [:index]

	def index
	end


	private 
		def set_root_collections
			@root_collections = Collection.without_parents.where is_public: true
			puts @root_collections
		end
end
