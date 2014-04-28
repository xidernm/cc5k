class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :fill_default_fields
  has_many :earnedbadges
  has_many :statistics
  belongs_to :region

  def admin?
    return roles.where(name: "Admin").take != nil
  end

  def fill_default_fields
    self.rank = 0
    self.score = 0
    self.effective_score = self.score
    self.wallpaper_id = 1
    self.save
  end

  def updateRank
    numberAnswers = Answer.where(user_id: id).count
    self.rank = 0
    self.rank = (Math.log2(self.score).floor) if self.score > 1

    puts self.save
    puts getGlobalAverage
  end

  private
  def getGlobalAverage
    sum = 0
    User.all.each do |user|
      if user.score != nil
        sum += user.score
      end
    end
    return (sum / User.all.count)
  end

  def getAnsweredFactorAverage

  end
end
