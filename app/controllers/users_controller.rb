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
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user].permit(:role_ids))
      redirect_to users_path, :notice => "User updated."
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
