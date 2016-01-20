class OperatingConditionsController < ApplicationController
  before_action :set_operating_condition, only: [:show, :edit, :update, :destroy]

  # GET /operating_conditions
  # GET /operating_conditions.json
  def index
    @operating_conditions = OperatingCondition.all
  end

  # GET /operating_conditions/1
  # GET /operating_conditions/1.json
  def show
  end

  # GET /operating_conditions/new
  def new
    @operating_condition = OperatingCondition.new
  end

  # GET /operating_conditions/1/edit
  def edit
  end

  # POST /operating_conditions
  # POST /operating_conditions.json
  def create

    sea_report_id = params[:operating_condition][:sea_report_id]
    @operating_condition = OperatingCondition.where(:sea_report_id => sea_report_id).first

    if @operating_condition.blank?
      @operating_condition = OperatingCondition.create(params[:operating_conditions])
    end

    respond_to do |format|
      if @operating_condition
        format.html { redirect_to edit_sea_report_path(sea_report_id), notice: 'Operating conditions are successfully updated.' }
        format.json { render :show, status: :created, location: @operating_condition }
      else
        format.html { render :new }
        format.json { render json: @operating_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operating_conditions/1
  # PATCH/PUT /operating_conditions/1.json
  def update
    respond_to do |format|
      if @operating_condition.update(operating_condition_params)
        format.html { redirect_to @operating_condition, notice: 'Operating condition was successfully updated.' }
        format.json { render :show, status: :ok, location: @operating_condition }
      else
        format.html { render :edit }
        format.json { render json: @operating_condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operating_conditions/1
  # DELETE /operating_conditions/1.json
  def destroy
    @operating_condition.destroy
    respond_to do |format|
      format.html { redirect_to operating_conditions_url, notice: 'Operating condition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operating_condition
      @operating_condition = OperatingCondition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operating_condition_params
      params[:operating_condition]
    end
end
