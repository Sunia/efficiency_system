class WeatherDistancesController < ApplicationController
  before_action :set_weather_distance, only: [:show, :edit, :update, :destroy]

  # GET /weather_distances
  # GET /weather_distances.json
  def index
    @weather_distances = WeatherDistance.all
  end

  # GET /weather_distances/1
  # GET /weather_distances/1.json
  def show
  end

  # GET /weather_distances/new
  def new
    @weather_distance = WeatherDistance.new
  end

  # GET /weather_distances/1/edit
  def edit
  end

  # POST /weather_distances
  # POST /weather_distances.json
  def create
    @weather_distance = WeatherDistance.new(weather_distance_params)

    respond_to do |format|
      if @weather_distance.save
        format.html { redirect_to @weather_distance, notice: 'Weather distance was successfully created.' }
        format.json { render :show, status: :created, location: @weather_distance }
      else
        format.html { render :new }
        format.json { render json: @weather_distance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_distances/1
  # PATCH/PUT /weather_distances/1.json
  def update
    respond_to do |format|
      if @weather_distance.update(weather_distance_params)
        format.html { redirect_to @weather_distance, notice: 'Weather distance was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_distance }
      else
        format.html { render :edit }
        format.json { render json: @weather_distance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_distances/1
  # DELETE /weather_dist
  def destroy
    sea_report_id = @weather_distance.sea_report_id

    @weather_distance.destroy
    respond_to do |format|
      format.html { redirect_to edit_sea_report_path(sea_report_id), notice: 'Observation is successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Create multiple weather distances
  def create_multiple_weather_distances

    weather_distances = params[:weather]

    unless weather_distances.blank?

      weather_distances.each.with_index do |weather_distance, index|
        @sea_report_id = params[:sea_report_id]
        @last_report = params[:weather][index]["last_report"]

        wd = WeatherDistance.new(weather_distance)
        wd.update_attributes(:sea_report_id => params[:sea_report_id])
        wd.update_attributes(params[:weather_second][index])
        wd.update_attributes(:position => params[:position][index])
        wd.save
      end
      
      # Calculate average and total of weather_and_distance
      WeatherDistance.calculate_average_of_weather_distance_fields(@sea_report_id)
    end

    respond_to do |format|
      format.html { redirect_to edit_sea_report_path(params[:sea_report_id]), notice: 'Information updated successfully' }
      format.js #{ render :js}# => "window.location.assign='"+ edit_sea_report_path(params[:sea_report_id]) +"'" }
      #format.html {redirect_to buildings_path} if params[:q].present?
      #render :js => "window.location.assign='"+ edit_sea_report_path(params[:sea_report_id]) +"'" 
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_distance
      @weather_distance = WeatherDistance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_distance_params
      params[:weather_distance]
    end
end