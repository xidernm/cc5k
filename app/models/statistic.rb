class Statistic < ActiveRecord::Base
  has_many :factors, dependent: :destroy
  
  
  def self.IsValidEquation(eqstr)
    /[A-Z]([+\-*\/][A-Z])*/ =~ eqstr.gsub(/\s+/,"")
  end

  def equationToRpn
    stack = []
    queue = []
    precedence = {'+'.to_s => 2, '-'.to_s => 2, '/'.to_s => 3, '*'.to_s => 3}
    
    equation.each_char do |c|
      if /[A-Z]/ =~ c
        queue << c
      else
        while !stack.empty? and precedence[stack.last] == precedence[c]
          queue << stack.pop
        end
        stack.push(c)
      end
    end
    (queue + stack.reverse).join
  end

  def EvalEquation(answer)
    eqn = equationToRpn
    stack = []
    ops = {"+" => lambda {|x,y| x + y},
           "-" => lambda {|x,y| x - y},
           "/" => lambda {|x,y| x / y},
           "*" => lambda {|x,y| x * y}}
    eqn.each_char do |c|
      if /[A-Z]/ =~ c
        stack.push(Factor.where(:statistic_id => id, :name => c).first.amount)
      else
        val1 = stack.pop
        val2 = stack.pop
        stack.push(ops[c].call(val1, val2))
      end
    end
    return stack.pop
  end
end
