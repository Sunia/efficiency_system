class ChangeDescriptionSeaReports < ActiveRecord::Migration
  def change
  	change_column :sea_reports, :description, :string, :default => "Ship clock has the same time"
  end
end
