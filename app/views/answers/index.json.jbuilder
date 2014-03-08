json.array!(@answers) do |answer|
  json.extract! answer, :id, :amount, :user_id, :statistic_id
  json.url answer_url(answer, format: :json)
end
