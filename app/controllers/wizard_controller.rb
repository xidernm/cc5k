class WizardController < ApplicationController

  def index
    mid = params[:format]
    @factors = Factor.all
    @mission = Mission.find_by(id: mid)
    @categories = Category.all
    @date = Time.new
    current_user.score += @mission.value
    current_user.save
  end

end
