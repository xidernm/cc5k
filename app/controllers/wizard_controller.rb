class WizardController < ApplicationController

  def index
    mid = params[:format]
    @mission = Mission.find_by(mid)
    @factors = Factor.find(:all, :group => "category_id, statistic_id", :conditions => "dependency = 2")
    @categories = Category.all
    @date = Time.new
    current_user.score += (@mission.value * current_user.rank)
    current_user.save
  end

end
