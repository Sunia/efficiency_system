class SeaReportsController < ApplicationController
  before_action :set_sea_report, only: [:show, :edit, :update, :destroy]

  # GET /sea_reports/1
  # GET /sea_reports/1.json
  def show
    @sea_report = SeaReport.find(params[:id])
    @count = @sea_report.report_number
  end

  def index
    # Check Sea Passage completed or not.
    @sea_port = SeaPort.last
    @sea_port_reached = @sea_port ? @sea_port.is_reached : false

    # Fetching open report
    @open_report = SeaReport.last
    @sea_reports = SeaReport.all
  end

  # GET /sea_reports/new
  def new
    @sea_report = SeaReport.new
  end

  # GET /sea_reports/1/edit
  def edit
    @sea_report = SeaReport.find(params[:id])
    @report_number = @sea_report.report_number

    @sea_port = SeaPort.find(@sea_report.sea_port_id)
    @sea_port.update_attributes(:total_reports => @sea_port.sea_reports.count)

    @passage_plans = @sea_report.passage_plans.order('waypoint_no asc')
    @passage_plan_count = @passage_plans.count

    # Weather and distance
    @weather_distances = @sea_report.weather_distances.order('created_at asc')
    @weather_distances_count = @weather_distances.count

    # @weather_distances = @sea_report.weather_distances.new
    # @weather_distances.update_attributes(:observation_smt => @sea_report.opened_time_in_smt, :observation_utc => @sea_report.created_at)
    
    if @sea_report.operating_conditions.blank?
      @operating_condition = @sea_report.operating_conditions.new
    else
      @operating_condition = @sea_report.operating_conditions.first
    end
  end

  # POST /sea_reports
  # POST /sea_reports.json
  def create
    begin
      @sea_report = SeaReport.new(sea_report_params)

      respond_to do |format|
        if @sea_report.save
          # Calculate smt and utc time of sea report
          # Update the 'smt_time' and 'created_at'.
          smt_time_string = "#{params[:date]} #{params[:hours]}:#{params[:minutes]}:#{params[:seconds]} #{params[:sea_report][:zone_time]}"
          utc_time = Time.parse(smt_time_string).getutc
          @sea_report.update_attributes(:opened_time_in_smt => smt_time_string, :created_at => utc_time)

          # update the report_number, sea_port_id of sea_report
          @sea_port = SeaPort.last

          if @sea_port

            @sea_report.report_number = @sea_port.sea_reports.count + 1
            @sea_report.sea_port_id = @sea_port.id
            @sea_report.is_closed = false
            @sea_report.save

            # Update the total_reports in sea_port
            @sea_port.total_reports += 1
            @sea_port.save

            format.html { redirect_to edit_sea_report_path(@sea_report.id), notice: 'Sea report is successfully created.' }
            format.json { render :show, status: :created, location: @sea_report }
          else
            format.html { redirect_to sea_reports_path, notice: 'First create the Sea Passage' }
          end

        else
          format.html { render :new }
          format.json { render json: @sea_report.errors, status: :unprocessable_entity }
        end
      end
    rescue
      format.html { render :new, notice: 'Some errors occured. Please try again' }
    end
  end

  # PATCH/PUT /sea_reports/1
  # PATCH/PUT /sea_reports/1.json
  def update
    respond_to do |format|
      if @sea_report.update(sea_report_params)
        format.html { redirect_to sea_reports_path, notice: 'Sea report was successfully updated.' }
        format.json { render :show, status: :ok, location: @sea_report }
      else
        format.html { render :edit }
        format.json { render json: @sea_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sea_reports/1
  # DELETE /sea_reports/1.json
  def destroy
    @sea_report.destroy
    respond_to do |format|
      format.html { redirect_to sea_reports_url, notice: 'Sea report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Close the sea report
  def close_report

    @old_sea_report = SeaReport.find(params[:id])

    # Calculate smt and utc time of sea report
    # Update the 'smt_time' and 'created_at'.
    zone_time = params[:sea_report][:zone_time]

    smt_time_string = "#{params[:date]} #{params[:hours]}:#{params[:minutes]}:#{params[:seconds]} #{params[:sea_report][:zone_time]}"
    closed_utc_time = Time.parse(smt_time_string).getutc

    # Condition to check closing time > start_time.
    if @old_sea_report.created_at > closed_utc_time
      redirect_to edit_sea_report_path(@old_sea_report.id), alert: 'Report cannot be closed as closing time is less than starting time!' and return
    end

    @old_sea_report.update_attributes(:closed_time_in_smt => smt_time_string, :closed_time_in_utc => closed_utc_time)

    # Report interval in hours.
    time_in_seconds  = @old_sea_report.closed_time_in_utc - @old_sea_report.created_at
    report_interval = Time.at(time_in_seconds).utc.strftime("%H:%M:%S")

    # Sea report is the last report ?
    @old_sea_report.is_last_report = params[:sea_report][:is_last_report]
    @old_sea_report.save

    updated = @old_sea_report.update_attributes(:is_closed => true, :report_period_in_hrs => report_interval)

    #================================================================

    unless @old_sea_report.is_last_report
      # Create new sea report and copy all the passage plans.
      @passage_plans = @old_sea_report.passage_plans
      @operating_conditions = @old_sea_report.operating_conditions
      status = create_sea_report(smt_time_string, closed_utc_time, zone_time, @passage_plans, @operating_conditions)

      respond_to do |format|
        if updated && status
          format.html { redirect_to edit_sea_report_path(@sea_report.id), notice: 'New sea report opened!' }
        end
      end

    else
      # Close the sea passage
      @sea_port = SeaPort.find(@old_sea_report.sea_port_id)
      closed_status = @sea_port.sea_passage_close

      respond_to do |format|
        if updated && closed_status
          format.html { redirect_to sea_reports_path, notice: 'Voyage completed !' }
        end
      end
    end
  end

  # Create new sea report after completion of the old sea report.
  def create_sea_report(smt_time_string, utc_time, zone_time, passage_plans, operating_conditions)

    # Create new report - starting time same as closing time of previous.
    @sea_report = SeaReport.new(:opened_time_in_smt => smt_time_string, :created_at => utc_time, :zone_time => zone_time, :update_passage_plan_date => Time.now )

    # Create weather_observation_smt and weather_observation_utc by adding 4 hours 
    observation_smt_time = create_weather_observation_smt_new_sea_report

    observation_utc_time = Time.parse(observation_smt_time).getutc

    @sea_report.update_attributes(:weather_observation_smt => observation_smt_time, :weather_observation_utc => observation_utc_time)

    if @sea_report.save

      # update the report_number, sea_port_id of sea_report
      @sea_port = SeaPort.last
 
      if @sea_port
        @sea_report.report_number = @sea_port.total_reports + 1
        @sea_report.sea_port_id = @sea_port.id
        @sea_report.is_closed = false
        @sea_report.save

        # Update the total_reports in sea_port
        @sea_port.total_reports += 1
        @sea_port.save

        # Update the passage plan of the sea port
        # by deleting the old plan and create a new one.
        @sea_port.passage_plans.delete_all

        # Copy all the passage plans of the previous report
        # to new report and Sea Port (sea_passage)
        passage_plans.each do |plan|
          # Passage plan for the new sea_report.
          new_passage_plan = @sea_report.passage_plans.new(plan.attributes.slice(*PassagePlan.accessible_attributes))
          new_passage_plan.save
        end

        operating_conditions.each do |condition|
          # Operating for the new sea_report.
          new_operating_condition = @sea_report.operating_conditions.new(condition.attributes.slice(*OperatingCondition.accessible_attributes))
          new_operating_condition.save
        end
        return true

      else
        return false
      end   
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sea_report
      @sea_report = SeaReport.find(params["id"])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sea_report_params
      params.require(:sea_report).permit(:is_closed, :closed_time_in_smt, :closed_time_in_utc, :report_number,  :zone_time, :report_interval)
    end

    # Create weather_observation_smt for new sea report.
    def create_weather_observation_smt_new_sea_report

      unless @old_sea_report.weather_distances.blank?
        previous_observation_smt = @old_sea_report.weather_distances.last.observation_smt

      else
        previous_observation_smt = @old_sea_report.weather_observation_smt
      end

      smtArray = previous_observation_smt.split(" ")
      date =  smtArray[0]
      time = smtArray[1]
      zone_time = smtArray[2]

      hr = time.split(":")[0].to_i
      
      # Add 4 hours to the previous observation_smt
      if hr < 4 && hr > 0
        new_hr = 4 
      elsif hr < 8 && hr > 4
        new_hr = 8 
      elsif hr < 12 && hr > 8
        new_hr = 12 
      elsif hr < 16 && hr > 12
        new_hr = 16 
      elsif hr < 20 && hr > 16
        new_hr = 20 
      elsif hr < 24 && hr > 20
        new_hr = 24 
      else 
        new_hr = hr + 4
      end

      # #===================================================

      #Calculate year,month and date
      year = date.split("-")[0].to_i
      month = date.split("-")[1].to_i
      day = date.split("-")[2].to_i

      # #===================================================

      if (new_hr > 20)
        new_hr = "00"

        is_leap = Date.leap?( year.to_i )

        if(day == 30 && month == 4 || month == 6 || month == 9 || month == 11)
          month = month + 1
          day = 1
        elsif(is_leap && month == 2 && day == 29)
          month = month + 1
          day = 1
        elsif(is_leap && month == 2 && day == 28)
          day = day + 1
        elsif(!is_leap && month == 2 && day == 28)
          month = month + 1
          day = day +1
        elsif(day == 31 && month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 )
          day = 1
          month = month + 1
        else
          day = day + 1
        end
        
        year = year + 1 if(month >= 12)

        month = "0#{month}" if(month < 10 )
        day = "0#{day}" if(day < 10)
        date = "#{year}-#{month}-#{day}"
      end

      new_hr = 0 if hr < 24 && hr > 20
      new_hr = "0#{new_hr}" if new_hr < 10
      observation_smt_time = "#{date} #{new_hr}:00:00 #{zone_time}"
    end
end