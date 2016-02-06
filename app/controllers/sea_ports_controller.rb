class SeaPortsController < ApplicationController

  # create new 'sea port' and set total_reports => 1
  # 'sea report corresponding to it' n Set report_number 1
  # Redirect to edit page of the sea report.

  def create
    # Calculate smt and utc time of sea report
    zone_time = params[:sea_port][:zone_time]
    smt_time_string = create_smt_time_for_sea_port(params[:date], params[:hours], zone_time)

    utc_time = Time.parse(smt_time_string).getutc

    @sea_port = SeaPort.new(sea_port_params)

    respond_to do |format|
      if @sea_port.save

        # Update the 'smt_time' and 'created_at'.
        @sea_port.update_attributes(:smt_time => smt_time_string, :created_at => utc_time, :total_reports => 0)
  
        # Create the new sea report
        @sea_report = @sea_port.sea_reports.create(:opened_time_in_smt => smt_time_string, :created_at => utc_time,  :zone_time => zone_time)
          
        # update the report_number, sea_port_id of sea_report
        @sea_report.report_number = @sea_port.total_reports + 1
        @sea_report.is_closed = false
        @sea_report.save

        # Update the total_reports in sea_port
        @sea_port.total_reports += 1
        @sea_port.save

        format.html { redirect_to edit_sea_report_path(@sea_report.id), notice: 'Sea report is successfully created.' }
        format.json { render :show, status: :created, location: @sea_report }
      else
        format.html { redirect_to sea_reports_path, notice: 'Some Exception occured. Please try again' }
      end
    end
  end

  def update
    @sea_port = SeaPort.find(params[:id])
    @sea_port.update(sea_port_params)
    
    respond_to do |format|
      if @sea_port.update(sea_port_params)  

        format.html { redirect_to edit_sea_report_path(@sea_port.id), notice: 'Information updated successfully' }
      else
        format.html { redirect_to edit_sea_report_path(@sea_port.id), notice: 'Please try again' }
      end  
    end
  end

  # Close sea_passage
  def close_sea_passage

    @sea_port = SeaPort.find(params[:id])
    # Todo close the report and update its time

    closed_status = @sea_port.sea_passage_close

    respond_to do |format|
      if closed_status
        format.html { redirect_to root_path, notice: 'Congrats For successfully completion of Journey'}
      else
        format.html { redirect_to sea_reports_path, notice: 'Please try again' }
      end  
    end
  end

  private

  def sea_port_params
    params.require(:sea_port).permit(:starting_port_name, :id, :reached_port_name, :description,  :vessel_name, :vessel_imo_no, :captain_name, :chief_engineer, :total_reports, :zone_time)
  end

  # Create SMT time
  def create_smt_time_for_sea_port(date, hour, zone_time)
    hr = hour.to_i
    hr = 4 if hr < 4 && hr > 0
    hr = 8 if hr < 8 && hr > 4
    hr = 12 if hr < 12 && hr > 8
    hr = 16 if hr < 16 && hr > 12
    hr = 20 if hr < 20 && hr > 16
    hr = 0 if hr < 24 && hr > 20

    hr = "0#{hr}" if hr < 10
    smt_time = "#{date} #{hr}:00:00 #{zone_time}"
    return smt_time
  end

end