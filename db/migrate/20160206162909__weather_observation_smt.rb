class WeatherObservationSmt < ActiveRecord::Migration
  def change
    add_column :sea_reports, :weather_observation_smt, :string
  	add_column :sea_reports, :weather_observation_utc, :datetime
  end
end
