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
        @chart
      end
    end
    end
  end

end
