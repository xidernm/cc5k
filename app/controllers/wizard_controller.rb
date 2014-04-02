class WizardController < ApplicationController

  def index
    @factors = Factor.all
  end

end
