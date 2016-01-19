class CreateOperatingConditions < ActiveRecord::Migration
  def change
    create_table :operating_conditions do |t|

      # Sea report id
      t.float :sea_report_id

      # Visual Draft
      t.float :visual_fwd
      t.float :visual_mid_ship
      t.float :visual_aft
      t.float :visual_trim

      # Loadicator Departure
      t.float :load_dep_fwd
      t.float :load_dep_mid_ship
      t.float :load_dep_aft
      t.float :load_dep_trim

      # Loadicator Daily Update
      t.float :load_daily_fwd
      t.float :load_daily_mid_ship
      t.float :load_daily_aft
      t.float :load_daily_trim

      # Metacentric Height
	  t.float :metacentric_height

      # Ballast water quantity
      t.float :ballast_water_quantity

      # Loading departure
      t.float :loading_dep_sf
      t.float :loading_dep_bm

      # Loading daily
      t.float :loading_daily_sf
      t.float :loading_daily_bm      


      t.timestamps null: false
    end
  end
end
