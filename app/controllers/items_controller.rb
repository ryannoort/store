class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    # @item_type = ItemType.includes(metadata_sets: [metadata_fields: [:metadata_values] ])
    #                     .where(item_types: {id: @item.item_type_id} , metadata_values: {valuable_type: @item.class.name, valuable_id: @item.id})
    #                     .first
    # @item_type = ItemType.fetch_for_item(@item).first
    # @item.item_type = ItemType.fetch_for_item(@item).first
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    # @item_types = ItemType.includes(metadata_sets: [metadata_fields: [:metadata_values] ])
    #                       .where(metadata_values: {item_id: @item.id})
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.owner = current_user
    
    if(params["parent_id"] != nil)
      @item.collections << Collection.find(params["parent_id"])
    end

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    results = Item.where(["name LIKE ?", "%#{params[:name]}%"])
    @items = results.paginate(page: params[:page], per_page: params[:per_page])
    @item_page = params[:page].to_i
    @item_per_page = params[:per_page].to_i
    @item_count = results.count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      item = params.fetch(:item, {}).permit(:name, :location, :start_time, :end_time, :is_public, :location, :item_type_id, metadata_values_attributes: [:value, :metadata_field_id])
      item[:location] = RGeo::GeoJSON.decode(item[:location], json_parser: :json)
      return item
    end
end
