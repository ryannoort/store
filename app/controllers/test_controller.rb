class TestController < ApplicationController
  def index
	@collections = Collection.where("parent_collection_id IS NULL")
  end
end
