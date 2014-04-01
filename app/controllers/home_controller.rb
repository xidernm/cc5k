class HomeController < ApplicationController

  def index
    if current_user!=nil
      fieldMap = MultiRBTree.new #non unique valued RedBlack Tree map from times to lists of answers
      ans = Answer.where(user_id: current_user.id)

      if ans != []
        ans.each do |a|
          if(a.month!=nil&&a.year!=nil&&a.amount!=nil)
            if(!fieldMap[Time.new(a.year,a.month)].present?)
              fieldMap[Time.new(a.year,a.month)] = []
            end
            fieldMap[Time.new(a.year,a.month)].push({:name =>Statistic.find(a.statistic_id).description,:val=>a.amount,:time => Time.new(a.year,a.month)})
          end
      end

#        @areaGraph =LazyHighCharts::HighChart.new('area') do |f|
#          f.series(:name=>current_user.firstName,:data=> fieldMap.values) # << Now we can query the Answer table for the user
#          f.title({ :text=>"Carbon Usage By Category"})
#          f.options[:chart][:defaultSeriesType] = "area"
#          f.options[:xAxis][:categories] = fieldMap.keys
#          f.colors
#          f.plot_options({:column=>{:stacking=>"percent"}})
#        end

        @distributionGraph =LazyHighCharts::HighChart.new('column') do |f|

          times =[]

          fieldMap.each_key do |k|
            times.push(k.strftime("%b %y"))
          end
            catValMap = Hash.new
          fieldMap.each_value do |t|
            t.each do |m|
                if !catValMap[m[:name]].present?
                  catValMap[m[:name]] = []
                end
                catValMap[m[:name]].push(m[:val])
            end
          end
         printf("\n\n\n\n\n\n\n\n%s\n\n\n\n\n\n\n\n",catValMap.inspect)
          catValMap.each_key {|key|  f.series(:name=>key,:data=>catValMap[key] )}
          f.title({ :text=> current_user.firstName + ": Carbon Usage History By Month"})
          f.options[:chart][:defaultSeriesType] = "column"
          f.options[:xAxis][:categories] = times
          f.options[:yAxis][:title] = {:text=>"Carbon Emitted (Tons)"}
          f.colors
          f.plot_options({:column=>{:stacking=>"normal"}})
        end
      end
    end
  end

  private

  def getAnsweredFactors
    answeredFactors = Answers.where(user_id: current_user.id)
  end
end
