class AddPassageUpdatedDate < ActiveRecord::Migration
  def change
  	add_column :sea_reports, :update_passage_plan_date, :datetime
  end
end
