json.array!(@operating_conditions) do |operating_condition|
  json.extract! operating_condition, :id
  json.url operating_condition_url(operating_condition, format: :json)
end
