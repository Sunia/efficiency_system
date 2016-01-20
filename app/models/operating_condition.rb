class OperatingCondition < ActiveRecord::Base

  attr_accessible :sea_report_id, :visual_fwd, :visual_mid_ship, :visual_aft, :visual_trim, :load_dep_fwd, :load_dep_mid_ship, :load_dep_aft, :load_dep_trim, :load_daily_fwd, :load_daily_mid_ship, :load_daily_aft, :load_daily_trim, :metacentric_height, :ballast_water_quantity, :loading_dep_sf, :loading_dep_bm, :loading_daily_sf, :loading_daily_bm
  has_one :sea_report
end
