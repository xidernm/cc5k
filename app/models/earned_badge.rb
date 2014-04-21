class EarnedBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :user

  def self.earn(user, title)
    eb = EarnedBadge.create
    eb.user_id = user.id
    eb.badge_id = Badge.where(title: title).first.id
    eb.save
  end

  def self.IsEarned?(user, title)
    user_badges = EarnedBadge.all.where(user_id: user.id)
    title_badge = Badge.all.where(title: title).first
    return EarnedBadge.all.where(user_id: user.id, badge_id: title_badge.id).count > 0
  end
end
