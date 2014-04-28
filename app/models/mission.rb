class Mission < ActiveRecord::Base  
  def self.getScore(current_user)
    return 2**current_user.rank
  end
end
