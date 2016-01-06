class AddWaypointToPassagePlan < ActiveRecord::Migration
  def change
    add_column :passage_plans, :waypoint_no, :string
  end
end
