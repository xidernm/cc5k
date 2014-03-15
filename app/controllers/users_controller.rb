class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin, :only => [:index, :update, :destroy]
#  $stateMap = {"Alabama"=>"Alabama","Alaska"=>"Alaska","Arizona"=>"Arizona","Arkansas"=>"Arkansas","California"=>"California","Colorado"=>"Colorado","Connecticut"=>"Connecticut","Delaware"=>"Delaware","District of Columbia"=>"District Of Columbia","Florida"=>"Florida","Georgia"=>"Georgia","Hawaii"=>"Hawaii","Idaho"=>"Idaho","Illinois"=>"Illinois","Indiana"=>"Indiana","Iowa"=>"Iowa","Kansas"=>"Kansas","Kentucky"=>"Kentucky","Louisana"=>"Louisiana","Maine"=>"Maine","Maryland"=>"Maryland","Massachusetts"=>"Massachusetts","Michigan"=>"Michigan","Minnesota"=>"Minnesota","Mississippi"=>"Mississippi","Missouri"=>"Missouri","Montana"=>"Montana","Nebraska"=>"Nebraska","Nevada"=>"Nevada","New Hampshire"=>"New Hampshire","New Jersey"=>"New Jersey","New Mexico"=>"New Mexico","New York"=>"New York","North Carolina"=>"North Carolina","North Dakota"=>"North Dakota","Ohio"=>"Ohio","Oklahoma"=>"Oklahoma","Oregon"=>"Oregon","Pennsylvania"=>"Pennsylvania","Rhode Island"=>"Rhode Island","South Carolina"=>"South Carolina","South Dakota"=>"South Dakota","TennesseN"=>"Tennessee","Texas"=>"Texas","Utah"=>"Utah","Vermont"=>"Vermont","Virginia"=>"Virginia","Washington"=>"Washington","West Virginia"=>"West Virginia","Wisconsin"=>"Wisconsin","Wyoming"=>"Wyoming"}
  def check_admin
    unless current_user.admin?
      authorize! :index, @user, :message => 'Not authorized as an administrator.'
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user].permit(:role_ids, :email, :firstName, :lastName, :state))
      redirect_to users_path, :notice => params.inspect
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
