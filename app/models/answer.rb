class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :statistic, dependent: :destroy
  has_many :answered_factors
end
