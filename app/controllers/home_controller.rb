class HomeController < ApplicationController

  def index
    @anon = AnonUser.new
    @anon.visited_page = "" << request.original_url
    @anon.ip = request.remote_ip
    if AnonUser.find_by(ip: request.remote_ip) == nil 
        @anon.save
    end
  end
  
  def contribution
    
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
#        series: [{
#                name: 'Asia',
#                data: [502, 635, 809, 947, 1402, 3634, 5268]
#                 }, {
#                name: 'Africa',
#                data: [106, 107, 111, 133, 221, 767, 1766]
#                 }, {
#                name: 'Europe',
#                data: [163, 203, 276, 408, 547, 729, 628]
#                 }, {
#                name: 'America',
#                data: [18, 31, 54, 156, 339, 818, 1201]
#                 }, {
#                name: 'Oceania',
#                data: [2, 2, 2, 6, 13, 30, 46]
#                 }]

        printf("\n\n\n\n\n\n\nfieldMAP\n\n\n\n\n\n\n%s\n\n:",catValSums.inspect)
        @areaGraph =LazyHighCharts::HighChart.new('area') do |f|
          catValSums.each do |key,val| 
          f.series(:name=>key,:data=> val)
          end
          f.title({ :text=>"Sum of Total Carbon Emissions"})
          f.options[:chart][:defaultSeriesType] = "area"
          f.options[:xAxis][:categories] = times
          f.options[:chart][:backgroundColor] = "#333"
          f.options[:colors] = ['#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263','#6AF9C4']
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
      end
    end
  end


  private

  def getAnsweredFactors
    answeredFactors = Answers.where(user_id: current_user.id)
  end
end
