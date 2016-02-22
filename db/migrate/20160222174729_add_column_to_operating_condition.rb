class AddColumnToOperatingCondition < ActiveRecord::Migration
  def change
  	add_column :operating_conditions, :dock_water_density, :float
  end
end
