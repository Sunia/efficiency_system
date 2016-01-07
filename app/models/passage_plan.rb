class PassagePlan < ActiveRecord::Base
  attr_accessible :long_degree, :long_min, :long_dir, :lat_degree, :lat_min, :lat_dir, :sea_report_id,:waypoint_no, :rl_gc, :start_point, :end_point
end
