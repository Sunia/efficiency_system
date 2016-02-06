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
    # hr = hour.to_i
    # new_hr = 4 if hr < 4 && hr > 0
    # new_hr = 8 if hr < 8 && hr > 4
    # new_hr = 12 if hr < 12 && hr > 8
    # new_hr = 16 if hr < 16 && hr > 12
    # new_hr = 20 if hr < 20 && hr > 16
    # new_hr = 24 if hr < 24 && hr > 20

    # #===================================================

    # #Calculate year,month and date
    # year = date.split("-")[0].to_i
    # month = date.split("-")[1].to_i
    # day = date.split("-")[2].to_i

    # #===================================================

    # if (new_hr > 20)
    #   new_hr = "00"

    #   is_leap = Date.leap?( year.to_i )

    #   if(day == 30 && month == 4 || month == 6 || month == 9 || month == 11)
    #     month = month + 1
    #     day = 1
    #   elsif(is_leap && month == 2 && day == 29)
    #     month = month + 1
    #     day = 1
    #   elsif(is_leap && month == 2 && day == 28)
    #     day = day + 1
    #   elsif(!is_leap && month == 2 && day == 28)
    #     month = month + 1
    #     day = day +1
    #   elsif(day == 31 && month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 )
    #     day = 1
    #     month = month + 1
    #   else
    #     day = day + 1
    #   end
      
    #   year = year + 1 if(month >= 12)

    #   month = "0#{month}" if(month < 10 )
    #   day = "0#{day}" if(day < 10)
    #   date = "#{year}-#{month}-#{day}"
    # end

    # new_hr = 0 if hr < 24 && hr > 20
    # new_hr = "0#{new_hr}" if new_hr < 10
    #smt_time = "#{date} #{new_hr}:00:00 #{zone_time}"
    smt_time = "#{date} #{hour}:00:00 #{zone_time}"
    return smt_time
  end

end