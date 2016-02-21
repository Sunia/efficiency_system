class PowerFuelsController < ApplicationController
  before_action :set_power_fuel, only: [:show, :edit, :update, :destroy]

  # GET /power_fuels
  # GET /power_fuels.json
  def index
    @power_fuels = PowerFuel.all
  end

  # GET /power_fuels/1
  # GET /power_fuels/1.json
  def show
  end

  # GET /power_fuels/new
  def new
    @power_fuel = PowerFuel.new
  end

  # GET /power_fuels/1/edit
  def edit
  end

  # POST /power_fuels
  # POST /power_fuels.json
  def create
    power_fuel = params[:power_fuel]
    sea_report_id = params[:power_fuel][:sea_report_id]
    @power_fuel = PowerFuel.where(:sea_report_id => sea_report_id.to_i).first

    if @power_fuel.blank?
      @power_fuel = PowerFuel.create(params[:power_fuel])
    else
      @power_fuel.update(params[:power_fuel])
    end

    # Set Total Avg. me power for Main Engine and calculate load MCR%
    load_mcr = (power_fuel["me_power"].to_i * 100)/1000

    @power_fuel.update_attributes(:me_total_average => power_fuel["me_power"], :me_load_mcr => load_mcr)

    # Total of each field in Oil consumers tab
    total =  {}
    total["oil_consumers_total_hshfo"] =   power_fuel[:oil_consumers_me_hshfo].to_f + power_fuel[:oil_consumers_aux_hshfo].to_f +  power_fuel[:oil_consumers_boiler_hshfo].to_f
    total["oil_consumers_total_lshfo"] =   power_fuel[:oil_consumers_me_lshfo].to_f + power_fuel[:oil_consumers_aux_lshfo].to_f +  power_fuel[:oil_consumers_boiler_lshfo].to_f
    total["oil_consumers_total_hsmdo"] =   power_fuel[:oil_consumers_me_hsmdo].to_f + power_fuel[:oil_consumers_aux_hsmdo].to_f +  power_fuel[:oil_consumers_boiler_hsmdo].to_f
    total["oil_consumers_total_lsmdo"] =   power_fuel[:oil_consumers_me_lsmdo].to_f + power_fuel[:oil_consumers_aux_lsmdo].to_f +  power_fuel[:oil_consumers_boiler_lsmdo].to_f
    total["oil_consumers_total_sludge"] =  power_fuel[:oil_consumers_boiler_sludge]

    # Calculate total power for Electrical Generators
    total["generators_total_power"] = power_fuel[:generators_aux1_power].to_i + power_fuel[:generators_aux2_power].to_i + power_fuel[:generators_aux3_power].to_i + power_fuel[:generators_aux4_power].to_i

    # Calculate total power for Electrical Consumers
    total["electrical_consumers_total_power"] = power_fuel["electrical_consumers_reefers_power"].to_i + power_fuel["electrical_consumers_reefer_cargo_power"].to_i + power_fuel["electrical_consumers_aux_power"].to_i

    @power_fuel.update_attributes(total)

    respond_to do |format|
      if @power_fuel
        format.html { redirect_to edit_sea_report_path(sea_report_id), notice: 'Power Fuel info is successfully updated.' }
        format.json { render :show, status: :created, location: @power_fuel }
      else
        format.html { render :new }
        format.json { render json: @power_fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /power_fuels/1
  # PATCH/PUT /power_fuels/1.json
  def update
    respond_to do |format|
      if @power_fuel.update(power_fuel_params)
        format.html { redirect_to @power_fuel, notice: 'Power fuel was successfully updated.' }
        format.json { render :show, status: :ok, location: @power_fuel }
      else
        format.html { render :edit }
        format.json { render json: @power_fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /power_fuels/1
  # DELETE /power_fuels/1.json
  def destroy
    @power_fuel.destroy
    respond_to do |format|
      format.html { redirect_to power_fuels_url, notice: 'Power fuel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_power_fuel
      @power_fuel = PowerFuel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def power_fuel_params
      params[:power_fuel]
    end
end
