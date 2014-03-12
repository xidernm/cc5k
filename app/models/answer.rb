class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :statistic
  has_many :answered_factors
end
