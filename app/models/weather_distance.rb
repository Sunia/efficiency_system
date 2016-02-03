class WeatherDistance < ActiveRecord::Base
  attr_accessible :sea_report_id,:observation_utc, :observation_smt, :position, :me_power, :me_rpm, :reliable_observation, :trip_counter_log, :trip_counter_gps, :distance_rem_eosp, :time_rem_eosp, :speed_knots, :speed_observed_knots, :true_wind_force, :true_wind_dir, :true_wind_speed_knots, :wave_height, :true_swell_direction, :true_swell_height, :water_depth, :couse_over_ground, :gyro_course,:compass_course, :avg_rudder_angle
  serialize :position

  belongs_to :sea_reports


  # Calculate average of somem fields of WeatherDistance
  # and save them in sea report record.
  def self.calculate_average_of_weather_distance_fields(sea_report_id)
    sea_report = SeaReport.find(sea_report_id)

    weather_distances = sea_report.weather_distances.order("created_at")
    # ME Power

    me_powers_arr = weather_distances.map(&:me_power)
    sea_report.avg_me_power = me_powers_arr.inject(0.0) { |sum, el| sum + el }/me_powers_arr.size

    # ME RPM
    me_rpm_arr = weather_distances.map(&:me_rpm)
    sea_report.avg_me_rpm = me_rpm_arr.inject(0.0) { |sum, el| sum + el }/me_rpm_arr.size

    # Speed log knots
    speed_knots_arr = weather_distances.map(&:speed_knots)
    sea_report.avg_speed_log_knots = speed_knots_arr.inject(0.0) { |sum, el| sum + el }/speed_knots_arr.size

    # Speed observed knots
    speed_observed_arr = weather_distances.map(&:speed_observed_knots)
    sea_report.avg_speed_observed_knots = speed_observed_arr.inject(0.0) { |sum, el| sum + el }/speed_observed_arr.size

    # Calculate total
    sea_report.total_trip_counter_log = weather_distances.last.trip_counter_log - weather_distances.first.trip_counter_log
    sea_report.total_trip_counter_gps = weather_distances.last.trip_counter_gps - weather_distances.first.trip_counter_gps

    sea_report.save
  end

end
