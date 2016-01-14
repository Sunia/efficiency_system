class AddRlGcToPassagePlan < ActiveRecord::Migration
  def change
    add_column :passage_plans, :rl_gc, :string
  end
end
