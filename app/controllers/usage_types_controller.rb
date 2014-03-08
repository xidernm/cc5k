class UsageTypesController < ApplicationController
  before_action :set_usage_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :check_admin, :only => [:index, :update, :destroy]

  def check_admin
    unless current_user.admin?
      authorize! :index, @user, :message => 'Not authorized as an administrator.'
    end
  end

  # GET /usage_types
  # GET /usage_types.json
  def index
    @users = User.all
    @usage_types = UsageType.all
  end

  # GET /usage_types/1
  # GET /usage_types/1.json
  def show
    @users = User.all
  end

  # GET /usage_types/new
  def new
    @usage_type = UsageType.new
  end

  # GET /usage_types/1/edit
  def edit
  end

  # POST /usage_types
  # POST /usage_types.json
  def create
    @usage_type = UsageType.new(usage_type_params)

    respond_to do |format|
      if @usage_type.save
        format.html { redirect_to @usage_type, notice: 'Usage type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @usage_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @usage_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usage_types/1
  # PATCH/PUT /usage_types/1.json
  def update
    respond_to do |format|
      if @usage_type.update(usage_type_params)
        format.html { redirect_to @usage_type, notice: 'Usage type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @usage_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usage_types/1
  # DELETE /usage_types/1.json
  def destroy
    @usage_type.destroy
    respond_to do |format|
      format.html { redirect_to usage_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usage_type
      @usage_type = UsageType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usage_type_params
      params.require(:usage_type).permit(:indirection, :type)
    end
end
