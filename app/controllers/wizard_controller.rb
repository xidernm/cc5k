class WizardController < ApplicationController

  def index
    mid = params[:format]
    @mission = Mission.find_by(id: mid)
    @factors = Factor.all
    @categories = Category.all
    @date = Time.new
    current_user.score += (@mission.value * current_user.rank)
    current_user.save
  end

end
