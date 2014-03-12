class RegionStatisticsController < ApplicationController
  before_action :set_region_statistic, only: [:show, :edit, :update, :destroy]

  # GET /region_statistics
  # GET /region_statistics.json
  def index
    @region_statistics = RegionStatistic.all
  end

  # GET /region_statistics/1
  # GET /region_statistics/1.json
  def show
  end

  # GET /region_statistics/new
  def new
    @region_statistic = RegionStatistic.new
  end

  # GET /region_statistics/1/edit
  def edit
  end

  # POST /region_statistics
  # POST /region_statistics.json
  def create
    @region_statistic = RegionStatistic.new(region_statistic_params)

    respond_to do |format|
      if @region_statistic.save
        format.html { redirect_to @region_statistic, notice: 'Region statistic was successfully created.' }
        format.json { render action: 'show', status: :created, location: @region_statistic }
      else
        format.html { render action: 'new' }
        format.json { render json: @region_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /region_statistics/1
  # PATCH/PUT /region_statistics/1.json
  def update
    respond_to do |format|
      if @region_statistic.update(region_statistic_params)
        format.html { redirect_to @region_statistic, notice: 'Region statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @region_statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /region_statistics/1
  # DELETE /region_statistics/1.json
  def destroy
    @region_statistic.destroy
    respond_to do |format|
      format.html { redirect_to region_statistics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region_statistic
      @region_statistic = RegionStatistic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def region_statistic_params
      params.require(:region_statistic).permit(:usage)
    end
end
