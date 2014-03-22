class HomeController < ApplicationController

  def index
    
<<<<<<< HEAD
    if current_user!=nil
      
      @ans = Answer.where(user_id: current_user.id)
      @ans.each do |a|
        a.name = Statistic.find(a.statistic_id).description
      end
      @areaGraph =LazyHighCharts::HighChart.new('area') do |f|
        f.series(:name=>current_user.firstName,:data=> [10, 20, 12,10]) # << Now we can query the Answer table for the user
        f.title({ :text=>"Carbon Usage Compared to Regional Average"})
=======
  if current_user!=nil

        fieldMap = Hash.new
       
        ans = Answer.where(user_id: current_user.id)
        ans.each do |a|
        fieldMap[Statistic.find(a.statistic_id).description] = a.amount
        end
        @areaGraph =LazyHighCharts::HighChart.new('area') do |f|
        f.series(:name=>current_user.firstName,:data=> fieldMap.values) # << Now we can query the Answer table for the user
        f.title({ :text=>"Carbon Usage By Category"})
>>>>>>> 758d4b9fcef20454ffd5e85a55583755625e6bbe
        f.options[:chart][:defaultSeriesType] = "area"
        f.options[:xAxis][:categories] = fieldMap.keys
        f.colors
        f.plot_options({:column=>{:stacking=>"percent"}})
<<<<<<< HEAD
      end
      @distributionGraph =LazyHighCharts::HighChart.new('column') do |f|
        f.series(:name=>'Vehicle',:data=>[10,12,9] )  
        f.series(:name=>'Food',:data=>[10,10,10] ) 
        f.series(:name=>'Heating',:data=>[25,20,30] ) 
        f.series(:name=>'Electrical',:data=>[25,20,30]) 
=======
        end
    
        @distributionGraph =LazyHighCharts::HighChart.new('column') do |f|
        fieldMap.each do |m|
        list = [10,m[1],20]
        f.series(:name=>m[0],:data=>list )  
        end
>>>>>>> 758d4b9fcef20454ffd5e85a55583755625e6bbe
        f.title({ :text=>"Carbon Usage Compared to Regional Average"})
        f.options[:chart][:defaultSeriesType] = "column"
        f.options[:xAxis][:categories] = ['National Average', current_user.firstName, 'Regional Average']
        f.colors
        f.plot_options({:column=>{:stacking=>"percent"}})
      end
    end
  end
  private
  def getAnsweredFactors
    answeredFactors = Answers.where(user_id: current_user.id)
  end
end
