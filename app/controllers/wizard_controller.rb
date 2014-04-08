class WizardController < ApplicationController

  def index
    @factors = Factor.all
    @categories = Category.all
  end

end
