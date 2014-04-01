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
    # TODO: We are accepting '=' characters into the Statistic Equation. If we do this 
    # we need to make sure that we take this into account appropriately.
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
    respond_to do |format|
      format.html { redirect_to statistics_url }
      format.json { head :no_content }
    end
  end

  # Routes to the fill in factors form
  def fill_in_factors
    a = params[:format]
    @statistic = Statistic.find_by(:id => a)
    @factors = Factor.where(:statistic_id => a)
  end

  # POST /submit_factor_changes
  # This code needs refactoring!
  
  # This function updates the changes that the admin wants to make to
  # the dependency, amount, and unit fields, then sends them back
  # to the statistics show page.
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


  # Dynamically create answers from user input.
  def create_answer
    current_stat_id = nil
    factorIds = []
    badFactors = []
    if params[:form_fields] != nil
      params[:form_fields].each do |field|
        current_stat_id = field[0].split(/[A-Z]/)[0] if current_stat_id != field[0].split(/[A-Z]/)[0]
        af = AnsweredFactor.where(factor_id: field[0].split(/[A-Z]/)[1], 
                                  amount: field[1], 
                                  statistic_id: current_stat_id,
                                  month: params[:month],
                                  year: params[:year],
                                  user_id: current_user.id).first_or_create
                                  
        
        if af.amount == nil
          badFactors.push(af)
          af.delete
        else
          factorIds.push([af.id, current_stat_id])
        end
      end
 
      if badFactors.count == 0 and factorIds.count != 0 
        userFactors = rearrangeFactors(factorIds)
        updateAnswer(userFactors,{:month=>params[:month],:year=>params[:year]})
      end
    end
    if badFactors.count == 0 and factorIds.count != 0
      redirect_to statistics_path
    else
      redirect_to emissions_template_path, alert: "Factor cannot be left blank."
    end
  end
    
  
  # Get /emissions_template
  def emissions_template
    @statistics = Statistic.all
    @user = current_user
    if params[:month] !=nil && params[:year]!=nil
      @time = Time.new(params[:year],params[:month])    
    end
    if @time == nil
      @time = Time.new
    end

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
          factors << fids[r-1..r-1]
        end
      end
    end
    return factors
  end
  
  # TODO: Make sure that users arent entering information 
  # in that could return an Answer of type Float::INFINITY
  def updateAnswer(ls,t)
    # ls is a list of list of answerd_factor_id, statistic_id pairs
    # t contains date information
    ls.each do |e|
      sid = e[0][1].to_i
      stat = Statistic.where(id: sid)
      
      amount = stat[0].EvalEquation(current_user.id, e)
      #if exists
      if Answer.where(user_id: current_user.id,statistic_id: sid,month: t[:month], year: t[:year]).first.present?
        Answer.where(user_id: current_user.id,statistic_id: sid,month: t[:month], year: t[:year]).first.update(:amount =>amount) #update the amount only
      else
        ans = Answer.where(amount: amount,user_id: current_user.id,statistic_id: sid,month: t[:month], year: t[:year]).create #otherwise create the field.
      end
    end
  end
end
