class AddAverageTotalWeather < ActiveRecord::Migration

  def change

    # Fields for the Average 
  	add_column :weather_distances, :avg_me_power, :float
  	add_column :weather_distances, :avg_me_rpm, :float
  	add_column :weather_distances, :avg_speed_log_knots, :float
  	add_column :weather_distances, :avg_speed_observed_knots, :float

    # Fields for the total 
    add_column :weather_distances, :total_trip_counter_log, :float
    add_column :weather_distances, :total_trip_counter_gps, :float
    add_column :weather_distances, :total_distance_rem_eosp, :float
    add_column :weather_distances, :total_time_rem_eosp, :float
  end
end
