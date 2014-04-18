class MissionsController < ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy]

  # GET /missions
  # GET /missions.json
  def index
    @missions = Mission.all
  end

  # GET /missions/1
  # GET /missions/1.json
  def show
      raise "fuck"
      redirect_to mission_explorer_path(id)
  end

  # GET /missions/new
  def new
    
    if current_user != nil && current_user.admin?
      @mission = Mission.new
    else
      redirect_to missions_path 
    end
  end

  # GET /missions/1/edit
  def edit
    if current_user != nil && !current_user.admin?
      redirect_to missions_path
    else
      @categories = Category.all
    end
    
  end

  # POST /missions
  # POST /missions.json
  def create
    if current_user.admin?
      @mission = Mission.new(mission_params)
      
      respond_to do |format|
        if @mission.save
          format.html { redirect_to @mission, notice: 'Mission was successfully created.' }
          format.json { render action: 'show', status: :created, location: @mission }
        else
          format.html { render action: 'new' }
          format.json { render json: @mission.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /missions/1
  # PATCH/PUT /missions/1.json
  def update
    respond_to do |format|
      if @mission.update(mission_params)
        format.html { redirect_to @mission, notice: 'Mission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /missions/1
  # DELETE /missions/1.json
  def destroy
    @mission.destroy
    respond_to do |format|
      format.html { redirect_to missions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params[:id])
    end
    
    
    def user_mission_select
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mission_params
      params.require(:mission).permit(:name, :description, :value, :user_id)
    end
end
