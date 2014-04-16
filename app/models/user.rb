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
    answers = Answer.where(id: id)
    if answers.count >= 0 && answers.count < 4 && self.rank < 9
       if self.rank == nil
      self.rank = 0
      end
      if self.score == nil
        self.score = 0
      end
      self.score = self.score + 50
      self.rank = self.rank + 1
      self.save
      return
    end
    
    answers
    
    if
    end false
  end
end
