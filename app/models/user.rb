class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :earnedbadges
  has_many :statistics
  belongs_to :region

  def admin?
    return roles.where(name: "Admin").take != nil
  end

  def updateRank
    numberAnswers = Answer.where(user_id: id).count
    if self.rank == nil
      self.rank = 0
    end

    if self.score == nil
      self.score = 10
    end
    self.rank = (Math.log2(self.score).floor)
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
