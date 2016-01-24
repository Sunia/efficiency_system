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
  # DELETE /weather_distances/1.json
  def destroy
    @weather_distance.destroy
    respond_to do |format|
      format.html { redirect_to weather_distances_url, notice: 'Weather distance was successfully destroyed.' }
      format.json { head :no_content }
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
