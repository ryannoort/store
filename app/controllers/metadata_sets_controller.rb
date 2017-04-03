class MetadataSetsController < ApplicationController
  before_action :set_metadata_set, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /metadata_sets
  # GET /metadata_sets.json
  def index
    @metadata_sets = MetadataSet.all
  end

  # GET /metadata_sets/1
  # GET /metadata_sets/1.json
  def show
  end

  # GET /metadata_sets/new
  def new
    @metadata_set = MetadataSet.new
    @metadata_set.metadata_fields.build   
  end

  # GET /metadata_sets/1/edit
  def edit
  end

  # POST /metadata_sets
  # POST /metadata_sets.json
  def create
    @metadata_set = MetadataSet.new(metadata_set_params)
    respond_to do |format|
      if @metadata_set.save
        format.html { redirect_to @metadata_set, notice: 'Metadata set was successfully created.' }
        format.json { render :show, status: :created, location: @metadata_set }
      else
        format.html { render :new }
        format.json { render json: @metadata_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metadata_sets/1
  # PATCH/PUT /metadata_sets/1.json
  def update
    respond_to do |format|
      if @metadata_set.update(metadata_set_params)
        format.html { redirect_to @metadata_set, notice: 'Metadata set was successfully updated.' }
        format.json { render :show, status: :ok, location: @metadata_set }
      else
        format.html { render :edit }
        format.json { render json: @metadata_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metadata_sets/1
  # DELETE /metadata_sets/1.json
  def destroy
    @metadata_set.destroy
    respond_to do |format|
      format.html { redirect_to metadata_sets_url, notice: 'Metadata set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metadata_set
      @metadata_set = MetadataSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metadata_set_params
      params.fetch(:metadata_set, {}).permit(:name, 
        metadata_fields_attributes: [:id, :field_type, :name, :hint, :default, :is_required, :order, :_destroy]
      )
    end
end
