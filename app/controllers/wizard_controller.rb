class WizardController < ApplicationController

  def index
    @factors = Factor.all
    @categories = Category.all(:include => :factors)
  end

end
