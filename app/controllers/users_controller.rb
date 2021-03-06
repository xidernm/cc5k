class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin, :only => [:index, :update, :destroy]
  def check_admin
    unless current_user.admin?
      authorize! :index, @user, :message => 'Not authorized as an administrator.'
    end
  end

  def index
    @users = User.all
  end

  def show
    current_user.updateRank
    @user_badges = EarnedBadge.order('created_at DESC').where(user_id: current_user.id)

    # earn the signed up badge if haven't already
    if !EarnedBadge.IsEarned?(current_user, "Signed Up")
      EarnedBadge.earn(current_user, "Signed Up")
    end

    # earn the Missionary badge
    if !EarnedBadge.IsEarned?(current_user, "Missionary") and AnsweredFactor.where(user_id: current_user.id).count > 0
      EarnedBadge.earn(current_user, "Missionary")
    end

    # earn the Fighter badge
    if !EarnedBadge.IsEarned?(current_user, "Fighter") and current_user.rank >= 2
      EarnedBadge.earn(current_user, "Fighter")
    end

    @most_recent_badge = @user_badges.first
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
