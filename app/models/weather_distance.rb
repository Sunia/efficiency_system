class WeatherDistance < ActiveRecord::Base
  attr_accessible :sea_report_id,:observation_utc, :observation_smt, :position, :me_power, :me_rpm, :reliable_observation, :trip_counter_log, :trip_counter_gps, :distance_rem_eosp, :time_rem_eosp, :speed_knots, :speed_observed_knots, :true_wind_force, :true_wind_dir, :true_wind_speed_knots, :wave_height, :true_swell_direction, :true_swell_height, :water_depth, :couse_over_ground, :gyro_course,:compass_course, :avg_me_power, :avg_me_rpm, :avg_speed_log_knots, :avg_speed_observed_knots, :total_trip_counter_log, :total_trip_counter_gps, :total_distance_rem_eosp, :total_time_rem_eosp

  belongs_to :sea_reports
end
