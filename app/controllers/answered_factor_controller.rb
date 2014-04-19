class AnsweredFactorController < ApplicationController
  respond_to :json

  def index
    @answeredFactors = AnsweredFactor.find(:all, :conditions => ["user_id = ?", current_user.id])
  end

  def show
    @answeredFactor = AnsweredFactor.find_by(statistic_id: params["id"], month: params["month"], year: params["year"])
#    respond_to do |format|
#      format.json
#    end
    render :json => @answeredFactor
  end

end
