class AddAverageSeaReports < ActiveRecord::Migration

  def change

    # Fields for the Average 
    add_column :sea_reports, :avg_me_power, :float, :precision => 2, :scale => 2
    add_column :sea_reports, :avg_me_rpm, :float, :precision => 2, :scale => 2
    add_column :sea_reports, :avg_speed_log_knots, :float, :precision => 2, :scale => 2
    add_column :sea_reports, :avg_speed_observed_knots, :float, :precision => 2, :scale => 2

    # Fields for the total 
    add_column :sea_reports, :total_trip_counter_log, :float, :precision => 2, :scale => 2
    add_column :sea_reports, :total_trip_counter_gps, :float, :precision => 2, :scale => 2
    add_column :sea_reports, :total_distance_rem_eosp, :float, :precision => 2, :scale => 2
    add_column :sea_reports, :total_time_rem_eosp, :float, :precision => 2, :scale => 2
  end
end
