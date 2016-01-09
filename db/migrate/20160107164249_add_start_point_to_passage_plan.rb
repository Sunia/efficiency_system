class AddStartPointToPassagePlan < ActiveRecord::Migration

  def change
    add_column :passage_plans, :start_point, :boolean, :default => false
    add_column :passage_plans, :end_point, :boolean, :default => false
  end
end
