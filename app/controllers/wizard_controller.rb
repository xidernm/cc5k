class WizardController < ApplicationController

  def index
    @factors = Factor.all
    @categories = Category.all
    @date = Time.new
  end

end
