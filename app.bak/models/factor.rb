class Factor < ActiveRecord::Base
  belongs_to :statistic
  has_many :answered_factors
end
