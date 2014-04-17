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

    if  numberAnswers >= 0 && numberAnswers < 4
      puts "Less than four answers "
      puts 'rank ' + self.rank.to_s + ', ' + id.to_s 
    elsif numberAnswers >= 4 && numberAnswers < 8 
      puts "More than 3 and less than 8 answers "
      puts 'rank ' + self.rank.to_s + ', ' + id.to_s 
    elsif numberAnswers >= 8 && numberAnswers < 16
      puts "More than 7 and less than 16 answers "
      puts 'rank ' + self.rank.to_s + ', ' + id.to_s 
    else 
      puts "More than 16 answers "
    end
    puts self.save
  end
end
