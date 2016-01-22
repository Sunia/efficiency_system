class AddMoreFieldsToOperating < ActiveRecord::Migration
  def change
  	add_column :operating_conditions, :speed_log_status, :string
	add_column :operating_conditions, :speed_log_date, :date

	add_column :operating_conditions, :vessel_fitted_with_torsion, :string
	add_column :operating_conditions, :torsion_meter_status, :string
	add_column :operating_conditions, :torsion_meter_date, :date

    add_column :operating_conditions, :roll_angle, :float
  end
end