json.array!(@statistics) do |statistic|
  json.extract! statistic, :id, :var1, :name1, :var2, :name2, :var3, :name3, :var4, :name4, :var5, :name5, :var6, :name6, :var7, :name7, :var8, :name8, :var9, :name9, :var10, :name10, :equation
  json.url statistic_url(statistic, format: :json)
end
