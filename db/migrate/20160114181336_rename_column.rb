class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :sea_reports, :report_interval, :report_period_in_hrs
  end
end
