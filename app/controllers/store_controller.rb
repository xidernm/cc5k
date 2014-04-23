class StoreController < ApplicationController
  def show
    @user = current_user
  end

  def upgrade_wallpaper
    @user = current_user
    alertStr = "You don't have enough resources."
    if @user.effective_score >= @user.wallpaper_id * 100 then
      @user.effective_score -= @user.wallpaper_id * 100
      @user.wallpaper_id += 1
      @user.save
      alertStr = "Environment upgraded."
    end
    redirect_to store_show_path, notice: alertStr
  end

  def buy_high_roller_badge
    @user = current_user
    alertStr = "You don't have enough resources."
    if @user.effective_score >= 1000 and !EarnedBadge.IsEarned?(@user, "High Roller") then
      @user.effective_score -= 1000
      EarnedBadge.earn(@user, "High Roller")
      @user.save
      alertStr = "Badge purchased."
    end
    redirect_to store_show_path, notice: alertStr
  end
end
