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

  
  def replaceName(factors, ch)
    factor = nil
    factors.each do |af|
      amount = AnsweredFactor.find_by(id: af[0]).amount
      factor = Factor.find_by(id: AnsweredFactor.find_by(id: af[0]).factor_id)
      if factor.name == ch
        factors.delete(af)
        return amount
      end
    end
    return nil
  end
  
  def EvalEquation(current_user, pairs)
    eqn = equationToRpn
    stack = []
    ops = {"+" => lambda {|x,y| x + y},
           "-" => lambda {|x,y| x - y},
           "/" => lambda {|x,y| x / y},
           "*" => lambda {|x,y| x * y}}
    num = nil
    eqn.each_char do |c|
      if /[A-Z]/ =~ c
        num = replaceName(pairs, c)
        # The logic here needs to be modified in order to replace variable names with values.
        if num != nil
          stack.push(num) 
        else
          num = Factor.find_by(statistic_id: id, name: c).amount
          stack.push(num)
        end
      else
        val1 = stack.pop
        val2 = stack.pop
        stack.push(ops[c].call(val1, val2))
      end
    end
    return stack.pop
  end
end
