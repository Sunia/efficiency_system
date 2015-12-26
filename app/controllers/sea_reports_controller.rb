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
    @sea_port = SeaPort.find(@sea_report.sea_port_id)
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
            @sea_report.report_number = @sea_port.total_reports + 1
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

  def close_report
    @sea_report = SeaReport.find(params[:id])

    # Calculate smt and utc time of sea report
    # Update the 'smt_time' and 'created_at'.
    smt_time_string = "#{params[:date]} #{params[:hours]}:#{params[:minutes]}:#{params[:seconds]} #{params[:sea_report][:zone_time]}"
    utc_time = Time.parse(smt_time_string).getutc
    @sea_report.update_attributes(:closed_time_in_smt => smt_time_string, :closed_time_in_utc => utc_time)

    time_difference_in_seconds  = @sea_report.updated_at - @sea_report.created_at
    report_interval = (time_difference_in_seconds/60/60)
    #report_interval = helper.distance_of_time_in_words(time_difference_in_seconds)

    updated = @sea_report.update_attributes(:is_closed => true, :closed_time_in_utc => DateTime.now, :report_interval => report_interval)

    respond_to do |format|
      if updated
        format.html { redirect_to sea_reports_path, notice: 'Sea report is successfully closed. Start a new one.....!' }
        format.json { render :show, status: :ok, location: @sea_report }
      else
        format.html { render :edit }
        format.json { render json: @sea_report.errors, status: :unprocessable_entity }
      end
    end
  end

  def passage_plan
    
    puts 'H'
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
end