class EarnedBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :user

  def self.earn(user, title)
    eb = EarnedBadge.create
    eb.user_id = user.id
    eb.badge_id = Badge.where(title: title).first.id
    eb.save
  end
end
