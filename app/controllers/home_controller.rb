class HomeController < ApplicationController

  def index
    if current_user!=nil
      fieldMap = Hash.new
      ans = Answer.where(user_id: current_user.id)

      if ans != []
        ans.each do |a|
          fieldMap[Statistic.find(a.statistic_id).description] = a.amount
        end

        @areaGraph =LazyHighCharts::HighChart.new('area') do |f|
<<<<<<< HEAD
          f.series(:name=>current_user.firstName,:data=> fieldMap.values) 
=======
          f.series(:name=>current_user.firstName,:data=> fieldMap.values) # << Now we can query the Answer table for the user
>>>>>>> 391f02e42c143e77a556cef7b011f99d9fefdb72
          f.title({ :text=>"Carbon Usage By Category"})
          f.options[:chart][:defaultSeriesType] = "area"
          f.options[:xAxis][:categories] = fieldMap.keys
          f.colors
          f.plot_options({:column=>{:stacking=>"percent"}})
        end

        @distributionGraph =LazyHighCharts::HighChart.new('column') do |f|
          fieldMap.each do |m|
            list = [10,m[1],20]
            f.series(:name=>m[0],:data=>list )
          end
          f.title({ :text=>"Carbon Usage Compared to Regional Average"})
          f.options[:chart][:defaultSeriesType] = "column"
          f.options[:xAxis][:categories] = ['National Average', current_user.firstName, 'Regional Average']
          f.colors
          f.plot_options({:column=>{:stacking=>"percent"}})
        end
      end
    end
  end

  private

  def getAnsweredFactors
    answeredFactors = Answers.where(user_id: current_user.id)
  end
end
