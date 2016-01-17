class SeaPort < ActiveRecord::Base
  has_many :sea_reports
  has_many :passage_plans

  def sea_passage_close

  	@sea_port = self
    last_sea_report = @sea_port.sea_reports.last
    last_report_passage_plans = last_sea_report.passage_plans 
    last_sea_report.update_attributes(:is_closed => true)

    # Pending 
    # Update closing date time in sea report

    # Update the passage plan of the sea port
    # by deleting the old plan and create a new one.
    @sea_port.passage_plans.delete_all

    last_report_passage_plans.each do |passage_plan|
      @sea_port.passage_plans << passage_plan
    end
    @sea_port.update_attributes(:is_reached => true)
    return true
  end

end
