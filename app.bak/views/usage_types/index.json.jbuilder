json.array!(@usage_types) do |usage_type|
  json.extract! usage_type, :id, :indirection, :type
  json.url usage_type_url(usage_type, format: :json)
end
