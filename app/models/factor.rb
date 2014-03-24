class Factor < ActiveRecord::Base
  belongs_to :statistic
  has_many :answered_factors, dependent: :destroy
end
