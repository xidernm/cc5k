json.array!(@earned_badges) do |earned_badge|
  json.extract! earned_badge, :id
  json.url earned_badge_url(earned_badge, format: :json)
end
