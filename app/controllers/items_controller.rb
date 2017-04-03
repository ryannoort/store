class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_items, only: [:index]
  load_and_authorize_resource

  # GET /items
  # GET /items.json
  def index    
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
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
    results = Item.where(["name LIKE ?", "%#{params[:query]}%"])
    results = addDateLimitGE(results, :start_time)
    results = addDateLimitLE(results, :end_time)
    results.where(is_public: true) unless current_user and current_user.admin?

    @items = results.order(created_at: :asc).paginate(page: params[:page], per_page: params[:per_page])
    @item_page = params[:page].to_i
    @item_per_page = params[:per_page].to_i
    @item_count = results.count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def set_items
      if current_user and (current_user.admin? or current_user.editor?)
        @items = Item.all
      else 
        @items = Item.where is_public: true
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      item = params.fetch(:item, {}).permit(:name, :location, :start_time, :end_time, :is_public, :location, :item_type_id, metadata_values_attributes: [:value, :metadata_field_id])
      item[:location] = RGeo::GeoJSON.decode(item[:location], json_parser: :json)
      return item
    end

    def addDateLimitGE(relation, symbol)
      addDateLimit(relation, symbol, ">=")      
    end

    def addDateLimitLE(relation, symbol)
      addDateLimit(relation, symbol, "<=")      
    end

    def addDateLimit(relation, symbol, comparisson_operator)
      begin 
        year, month, day = params[symbol].split('-').map {|s| s.to_i}      
        if Date.valid_date?(year, month, day)
          return relation.where([symbol.to_s + " " + comparisson_operator+" :date", date: Date.new(year,month,day)])
        end
      rescue
        return relation
      end      
      return relation
    end
end
