json.array!(@passage_plans) do |passage_plan|
  json.extract! passage_plan, :id
  json.url passage_plan_url(passage_plan, format: :json)
end
