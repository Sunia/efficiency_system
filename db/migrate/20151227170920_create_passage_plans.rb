class CreatePassagePlans < ActiveRecord::Migration
  def change
    create_table :passage_plans do |t|

      t.integer :lat_degree
      t.float :lat_min
      t.string :lat_dir

      t.integer :long_degree
      t.float :long_min
      t.string :long_dir

      t.string :status, :default => 'new'
      t.integer :sea_report_id

      t.timestamps null: false
    end
  end
end
