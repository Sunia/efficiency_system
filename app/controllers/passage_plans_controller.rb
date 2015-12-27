class PassagePlansController < ApplicationController
  before_action :set_passage_plan, only: [:show, :edit, :update, :destroy]

  # GET /passage_plans
  # GET /passage_plans.json
  def index
    @passage_plans = PassagePlan.all
  end

  # GET /passage_plans/1
  # GET /passage_plans/1.json
  def show
  end

  # GET /passage_plans/new
  def new
    @passage_plan = PassagePlan.new
  end

  # GET /passage_plans/1/edit
  def edit
  end

  # POST /passage_plans
  # POST /passage_plans.json
  def create
    @passage_plan = PassagePlan.new(passage_plan_params)

    respond_to do |format|
      if @passage_plan.save
        format.html { redirect_to @passage_plan, notice: 'Passage plan was successfully created.' }
        format.json { render :show, status: :created, location: @passage_plan }
      else
        format.html { render :new }
        format.json { render json: @passage_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /passage_plans/1
  # PATCH/PUT /passage_plans/1.json
  def update
    respond_to do |format|
      if @passage_plan.update(passage_plan_params)
        format.html { redirect_to @passage_plan, notice: 'Passage plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @passage_plan }
      else
        format.html { render :edit }
        format.json { render json: @passage_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passage_plans/1
  # DELETE /passage_plans/1.json
  def destroy
    @passage_plan.destroy
    respond_to do |format|
      format.html { redirect_to passage_plans_url, notice: 'Passage plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Passage Plan
  def create_passage_plan
    passage_plans = params[:passage]
    passage_plans.each do |passage_plan|
      plan = PassagePlan.new(passage_plan)
      plan.update_attributes(:sea_report_id => params[:sea_report_id])
      plan.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_passage_plan
      @passage_plan = PassagePlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def passage_plan_params
      #params.permit(:passage, array: [:long_degree, :long_min, :long_dir, :lat_degree, :lat_min, :lat_dir, :sea_report_id])
      params.require(:passage).permit(:all)
    end
end
