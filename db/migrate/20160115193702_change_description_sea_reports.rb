class ChangeDescriptionSeaReports < ActiveRecord::Migration
  def change
  	change_column :sea_reports, :description, :string, :default => "Zone time remains the same."
  end
end
