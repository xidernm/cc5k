class HomeController < ApplicationController

  def index
  if current_user!=nil
    @usage =LazyHighCharts::HighChart.new('column') do |f|
        f.series(:name=>current_user.email,:data=> [10, 20, 12,700])
        f.series(:name=>'Average',:data=>[2, 19, 4, 950] ) 
        f.title({ :text=>"Carbon Usage Compared to Regional Average"})
        f.options[:chart][:defaultSeriesType] = "column"
        f.options[:xAxis][:categories] = ['Vehicle', 'Natural Gas', 'Electric','Food']
        f.plot_options({:column=>{:stacking=>"percent"}})
        end
    end
  end
end
