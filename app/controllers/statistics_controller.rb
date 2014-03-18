class StatisticsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_statistic, :only => [:show, :edit, :update, :destroy]

  # GET /statistics
  # GET /statistics.json
  def index
    @statistics = Statistic.all
  end

  # GET /statistics/1
  # GET /statistics/1.json
  def show
    if current_user.admin?
      redirect_to fill_in_factors_path(@statistic.id)
    else
      @statistic
    end
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
    @statistic = Statistic.find_by(:id => a)
    @factors = Factor.where(:statistic_id => a)
  end

  # POST /submit_factor_changes
  # This code needs refactoring!
  def submit_factor_changes
    params[:factor_depends].each do |factor|
      f = Factor.find_by(id: factor[0][0..-1])
      f.dependency = factor[1]
      f.save
    end

    params[:factor_amount].each do |factor|
      f = Factor.find_by(id: factor[0][0..-1])
      f.amount = factor[1][0..-1]
      f.save
    end
    
    params[:factor_unit].each do |factor|
      f = Factor.find_by(id: factor[0])
      f.unit = factor[1..-1].join
      f.save
    end
    redirect_to statistics_path
  end

  def create_answer
    current_stat_id = nil
    factorIds = []
    params[:form_fields].each do |field|
      current_stat_id = field[0][0] if current_stat_id != field[0][0]
      af = AnsweredFactor.where(factor_id: field[0][2..-1], 
                                amount: field[1], 
                                statistic_id: current_stat_id, 
                                user_id: current_user.id).first_or_create
    
      factorIds.push([af.id, current_stat_id])
    end
    userFactors = rearrangeFactors(factorIds)
    updateAnswer(userFactors)
    redirect_to statistics_path
  end
    
  def updateAnswer(ls)
    # ls is a list of list of answerd_factor_id, statistic_id pairs
    ls.each do |e|
      # e is a list of answered_factor_id, statistic_id pairs
      sid = e[0][1].to_i
      stat = Statistic.where(id: sid)
      amount = stat[0].EvalEquation(current_user.id, e)
      ans = Answer.where(amount: amount, user_id: current_user.id, statistic_id: sid).create
    end
  end

  # Get /fill_out_form
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
  end
  
  def rearrangeFactors(fids)
    factors = []
    l = 0 
    r = 1
    while r < fids.count
      if fids[l][1] == fids[r][1]
        r = r + 1
        if r == fids.count
          factors << fids[l..r-1]
        end
      else
        factors << fids[l..r-1]
        l = r
        r = r + 1
        if r == fids.count
          factors << b[r-1..r-1]
        end
      end
    end
    return factors
  end
end

