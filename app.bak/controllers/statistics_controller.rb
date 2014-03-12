class StatisticsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin, :only => [:index, :update, :destroy]
  before_action :set_statistic, :only => [:show, :edit, :update, :destroy]

  def check_admin
    unless current_user.admin?
      authorize! :index, @user, :message => 'Not authorized as an administrator.'
    end
  end

  # GET /statistics
  # GET /statistics.json
  def index
    @statistics = Statistic.all
  end

  # GET /statistics/1
  # GET /statistics/1.json
  def show
    redirect_to fill_in_factors_path(@statistic.id)
  end

  # GET /statistics/new
  def new
    @statistic = Statistic.new
  end

  # GET /statistics/1/edit
  def edit
  end

  # POST /statistics
  # POST /statistics.json
  def create
    if Statistic.IsValidEquation(statistic_params[:equation])
      @statistic = Statistic.new(statistic_params)
      respond_to do |format|
        if @statistic.save
          create_factors_for_statistic(@statistic)
          format.html { redirect_to @statistic, notice: 'Statistic was successfully created.' }
          format.json { render action: 'show', status: :created, location: @statistic }
        else
          format.html { render action: 'new' }
          format.json { render json: @statistic.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to new_statistic_path, alert: "Equation '#{statistic_params[:equation]}' is invalid."
    end
  end

  # PATCH/PUT /statistics/1
  # PATCH/PUT /statistics/1.json
  def update
    respond_to do |format|
      if @statistic.update(statistic_params)
        create_factors_for_statistic(@statistic)
        format.html { redirect_to @statistic, notice: 'Statistic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.json
  def destroy
    @statistic.destroy
    Factor.where(:statistic_id => @statistic.id).each do |s|
      s.destroy
    end
    respond_to do |format|
      format.html { redirect_to statistics_url }
      format.json { head :no_content }
    end
  end


  def fill_in_factors
    a = params[:format]
    @factors = Factor.where(:statistic_id => a)
  end


  def create_answer
    current_stat_id = nil
    params[:form_fields].each do |field|
      current_stat_id = field[0][0] if current_stat_id != field[0][0]
      s = Statistic.find(field[0][0])
      Answer.where(statistic_id: s.id, user_id: current_user.id, name: field[0][1..-1], amount: field[1]).create
    end
    redirect_to answers_path
  end

  def fill_out_form
    @statistics = Statistic.all
    @user = current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
 def set_statistic
      @statistic = Statistic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statistic_params
      params.require(:statistic).permit(:equation, :description)
    end

    def create_factors_for_statistic(statistic)
      Factor.where(statistic_id: statistic.id).destroy_all
      statistic.equation.gsub(/\s+/,"").split(/[*+-\/]/).delete_if(&:empty?).each do |factor|
        name_check = Integer(factor) rescue nil
        if name_check == nil
          Factor.where(name: factor, statistic_id: statistic.id).first_or_create
        else
          Factor.where(value: factor, statistic_id: statistic.id).first_or_create
        end
      end

      # TODO: Redirect to page that allows the admin to decide what kind of factor
      # each variable in the equation is.
    end
  end

