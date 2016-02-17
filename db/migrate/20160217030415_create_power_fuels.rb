class CreatePowerFuels < ActiveRecord::Migration
  def change
    create_table :power_fuels do |t|

      t.timestamps null: false
    end
  end
end
