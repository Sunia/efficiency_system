class IsLastReportToSeaReports < ActiveRecord::Migration
  def change
  	add_column :sea_reports, :is_last_report, :boolean, :default => false
  end
end
