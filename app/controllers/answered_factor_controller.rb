class AnsweredFactorController < ApplicationController
  respond_to :json

  def index
    @answeredFactors = AnsweredFactor.find(:all, :conditions => ["user_id = ?", current_user.id])
  end

  def show
    @answeredFactor = AnsweredFactor.find_by(id: params["id"], month: params["month"], year: params["year"])
    render :json => @answeredFactor
  end

end
