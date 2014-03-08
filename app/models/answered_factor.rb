class AnsweredFactor < ActiveRecord::Base
  belongs_to :answer
  belongs_to :factor
end
