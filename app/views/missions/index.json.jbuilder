json.array!(@missions) do |mission|
  json.extract! mission, :id, :name, :description, :value, :user_id
  json.url mission_url(mission, format: :json)
end
