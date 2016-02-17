json.array!(@power_fuels) do |power_fuel|
  json.extract! power_fuel, :id
  json.url power_fuel_url(power_fuel, format: :json)
end
