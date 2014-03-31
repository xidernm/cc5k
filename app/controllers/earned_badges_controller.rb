class EarnedBadgesController < ApplicationController
  before_action :set_earned_badge, only: [:show, :edit, :update, :destroy]
  before_action :login_redirect


  def login_redirect
    if current_user == nil
      redirect_to root_path, alert: "Log in to view your badges."
    end
  end

  # GET /earned_badges
  # GET /earned_badges.json
  def index
    @earned_badges = EarnedBadge.all
    @user_badges = EarnedBadge.where(user_id: current_user.id)
  end

  # GET /earned_badges/1
  # GET /earned_badges/1.json
  def show
  end

  # GET /earned_badges/new
  def new
    @earned_badge = EarnedBadge.new
  end

  # GET /earned_badges/1/edit
  def edit
  end

  # POST /earned_badges
  # POST /earned_badges.json
  def create
    @earned_badge = EarnedBadge.new(earned_badge_params)

    respond_to do |format|
      if @earned_badge.save
        format.html { redirect_to @earned_badge, notice: 'Earned badge was successfully created.' }
        format.json { render action: 'show', status: :created, location: @earned_badge }
      else
        format.html { render action: 'new' }
        format.json { render json: @earned_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /earned_badges/1
  # PATCH/PUT /earned_badges/1.json
  def update
    respond_to do |format|
      if @earned_badge.update(earned_badge_params)
        format.html { redirect_to @earned_badge, notice: 'Earned badge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @earned_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /earned_badges/1
  # DELETE /earned_badges/1.json
  def destroy
    @earned_badge.destroy
    respond_to do |format|
      format.html { redirect_to earned_badges_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_earned_badge
      @earned_badge = EarnedBadge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def earned_badge_params
      params[:earned_badge]
    end
end
