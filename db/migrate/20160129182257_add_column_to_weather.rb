class AddColumnToWeather < ActiveRecord::Migration
  def change
	add_column :weather_distances, :avg_rudder_angle, :float
  end
end
