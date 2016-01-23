json.array!(@weather_distances) do |weather_distance|
  json.extract! weather_distance, :id
  json.url weather_distance_url(weather_distance, format: :json)
end
