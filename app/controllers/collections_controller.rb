class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :tree]
  before_action :set_collections, only: [:index]
  # load_and_authorize_resource
  
  # GET /collections
  # GET /collections.json
  def index
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    # @item_type = ItemType.includes(metadata_sets: [metadata_fields: [:metadata_values] ]).where(item_types: {id: @collection.item_type_id} , metadata_values: {valuable_id: @collection.id}).first
    # @item_type = ItemType.fetch_for_item(@collection).first
  end

  # GET /collections/new
  def new
   @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)
    @collection.owner = current_user

    respond_to do |format|
      if @collection.save
        # @collection.update_item_type collection_params['item_type_id']
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        # @collection.update_item_type collection_params['item_type_id']
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /collections/tree/1.json
  def tree
  end

  # GET /collections/trees.json
  def trees
    results = Collection.where(["name LIKE ?", "%#{params[:query]}%"])
    @collections = results.paginate(page: params[:page], per_page: params[:per_page])
    @collection_page = params[:page].to_i
    @collection_per_page = params[:per_page].to_i
    @collection_count = results.count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    def set_collections
      if current_user and (current_user.admin? or current_user.editor?)
        @collections = Collection.all
      else 
        @collections = Collection.where is_public: true
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      # params.fetch(:collection, {}).permit(:parent_collection_id, :name, :form_attributes => [ :id, :schema_id, :fields_attributes => [:id, :name, :content, :type, :mime_content] ])
      params.fetch(:collection, {}).permit(:name, :item_type_id, item_ids: [], collection_ids: [], metadata_values_attributes: [:value, :metadata_field_id])
    end
end
