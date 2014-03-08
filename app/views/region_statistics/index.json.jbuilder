json.array!(@region_statistics) do |region_statistic|
  json.extract! region_statistic, :id, :usage
  json.url region_statistic_url(region_statistic, format: :json)
end
