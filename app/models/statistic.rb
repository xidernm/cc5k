class Statistic < ActiveRecord::Base
  has_many :factors, dependent: :destroy

  def self.IsValidEquation(eqstr)
    /[A-Z]([+\-*\/][A-Z])*/ =~ eqstr.gsub(/\s+/,"")
  end

end
