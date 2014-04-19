class WizardController < ApplicationController
  helper_method :chart

  def index
    mid = params[:format]
    @factors = Factor.all
    @mission = Mission.find_by(id: mid)
    @categories = Category.all
    @date = Time.new
    @chart = nil
    current_user.score += @mission.value
    current_user.save
  end

  def chart
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
end
      monthData = [];
      thisMonth = fieldMap[Time.new(params[:year],params[:month])];
      sum = 0;
      if thisMonth !=nil
        thisMonth.each do |i|
          sum+=i[:val]
        end

      thisMonth.each do |i|
        monthData.push([i[:name],((i[:val]/sum)*100).round(3)])
      end

      @chart = LazyHighCharts::HighChart.new('pie') do |f|
        f.chart({:defaultSeriesType=>"pie"})
        series = {
          :type=> 'pie',
          :name=> 'Current Month Distribution of Emissions',
          :data=> monthData
        }
        f.series(series)
        f.options[:title][:text] = 'Current Month Distribution of Emissions'
        f.plot_options(:pie=>{
          :allowPointSelect=>true, 
          :dataLabels=>{
          :enabled=>true,
          :color=>"white",
          :style=>{
            :font=>"15cd ..px Trebuchet MS, Verdana, sans-serif"
          }
          }
        })

      end

    end
printf("\n\n\n\nchart: %s\n\n\n\n",@chart);
asdf = 5
render :text =>@chart
    end
  end

end
