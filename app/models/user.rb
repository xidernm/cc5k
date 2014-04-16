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
        
  end
end
