class HomeController < ApplicationController

  def index
    @anon = AnonUser.new
    @anon.visited_page = "" << request.original_url
    @anon.ip = request.remote_ip
    if AnonUser.find_by(ip: request.remote_ip) == nil 
        @anon.save
    end
  end
  def month_chart
    if params[:month] !=nil && params[:year]!=nil
      @time = Time.new(params[:year],params[:month])    
    end
    if @time == nil
      @time = Time.new
    end
     @user = current_user                                                                                                   
  end
  def contribution
    if params[:month] !=nil && params[:year]!=nil
      @time = Time.new(params[:year],params[:month])    
    end
    if @time == nil
      @time = Time.new
    end
     @user = current_user                                                                                                   
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
  catValSums = Hash.new
        cSum = 0;
        catValMap.each do |key,val|
        sums = []
        val.each do |n|
          cSum += n
          sums.push(cSum);
        end
        catValSums[key] =sums
end

        @areaGraph =LazyHighCharts::HighChart.new('area') do |f|
          catValSums.each do |key,val| 
          f.series(:name=>key,:data=> val)
          end
          f.title({ :text=>"Sum of Total Carbon Emissions"})
          f.options[:chart][:defaultSeriesType] = "area"
          f.options[:xAxis][:categories] = times
          f.options[:chart][:backgroundColor] = "#333"
          f.options[:colors] = ['#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263','#6AF9C4']
          f.options[:yAxis][:title] = {:text=>"Carbon Emitted (Tons)"}
          f.plot_options({:area=>{:stacking=>"normal"}})
       end
        
        @distributionGraph =LazyHighCharts::HighChart.new('column') do |f|
          catValMap.each_key {|key|  f.series(:name=>key,:data=>catValMap[key] )}
          f.title({ :text=> current_user.firstName + ": Carbon Usage History By Month"})
          f.options[:chart][:defaultSeriesType] = "column"
          f.options[:chart][:backgroundColor] = "#333"
          f.options[:xAxis][:categories] = times
          f.options[:yAxis][:title] = {:text=>"Carbon Emitted (Tons)"}

          f.options[:colors] = ['#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263','#6AF9C4']
          f.plot_options({:column=>{:stacking=>"normal"}})
        end

        monthData = [];
        thisMonth = fieldMap[Time.new(@time.year,@time.month)];
        sum = 0;
        if thisMonth !=nil
        thisMonth.each do |i|
        sum+=i[:val]
        end

        thisMonth.each do |i|
          monthData.push([i[:name],i[:val]/sum])
        end
        
  @monthChart = LazyHighCharts::HighChart.new('pie') do |f|
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
    :font=>"15px Trebuchet MS, Verdana, sans-serif"
          }
        }
       }
  )
        end
      end
    end
  end
end


  private

  def getAnsweredFactors
    answeredFactors = Answers.where(user_id: current_user.id)
  end
end
