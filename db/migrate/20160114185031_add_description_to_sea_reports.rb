class AddDescriptionToSeaReports < ActiveRecord::Migration
  def change
  	add_column :sea_reports, :description, :text
  end
end
