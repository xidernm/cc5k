class WizardController < ApplicationController

  def index
    @missions = Mission.all
    @factors = Factor.all
    @categories = Category.all
    @date = Time.new
  end

  def index_from_missions(mid)
    @mission = Mission.find_by(id: mid)
  end

end
