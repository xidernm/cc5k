json.array!(@factors) do |factor|
  json.extract! factor, :id, :name, :value
  json.url factor_url(factor, format: :json)
end
