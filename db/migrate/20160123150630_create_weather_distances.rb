class CreateWeatherDistances < ActiveRecord::Migration
  def change
    create_table :weather_distances do |t|

	  # Observation date n  time (UTC) 
      t.datetime :observation_utc

      # Observation date n time (SMT)
      t.datetime :observation_smt

	  # Position ( latitude/ Longitude) - Lat degree n min N/S
      t.string :position

	  # ME Power (MAin Engine Power)(In Kw)
      t.integer :me_power
 
      # ME RPM
      t.integer :me_rpm

	  # Reliable observation
      t.integer :reliable_observation

      # Trip counter log (Nm)
      t.integer :trip_counter_log

      # Trip counter(GPS) Nm
      t.integer :trip_counter_gps

      # Distance remaining to EOSP(NM)
      t.integer  :distance_rem_eosp

      # Time remaining to EOSP(hours)
      t.integer :time_rem_eosp

      # Speed Logged  in Knots
      t.float :speed_knots

      # True wind force (BF)
      t.integer :true_wind_force

      # True Wind direction (0-359) degrees
      t.integer :true_wind_dir

      # True wind speed in Knots
      t.float :true_wind_speed_knots

      # Wave height in meters(Seas)
      t.float :wave_height
      
	  # True Swell Direction (0-359 degrees)
      t.integer :true_swell_direction

	  # True Swell height in meters
	  t.float :true_swell_height

	  #Water depth in meters
	  t.integer :water_depth

	  # Couse over ground.(0-359)
	  t.integer :couse_over_ground

	  #Gyro course (0-359)
      t.integer :gyro_course

	  # Compass course (0-359)
	  t.integer :compass_course

      t.timestamps null: false
    end
  end
end
