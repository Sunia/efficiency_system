class ReportIntervalInHhMmSs < ActiveRecord::Migration
  def change
  	change_column :sea_reports, :report_period_in_hrs, :string, :default => "00:00:00"
  end
end
