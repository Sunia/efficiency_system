class AddSeaPortIdToPassagePlan < ActiveRecord::Migration
  def change
    add_column :passage_plans, :sea_port_id, :integer

  end
end
