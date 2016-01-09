class PassagePlansController < ApplicationController
  before_action :set_passage_plan, only: [:show, :edit, :update]

  # GET /passage_plans
  # GET /passage_plans.json
  def index

    if params[:sea_report_id]
      @sea_report_id = params[:sea_report_id]

      @passage_plans = SeaReport.find(@sea_report_id).passage_plans

      @passage_plans = @passage_plans.order('waypoint_no asc')
    else
      @passage_plans = PassagePlan.all.order('waypoint_no asc')
    end

  end

  # GET /passage_plans/1
  # GET /passage_plans/1.json
  def show
  end

  # GET /passage_plans/new
  def new
    if params[:previous_passage_id]
     @previous_passage = PassagePlan.find(params[:previous_passage_id])
     previous_waypoint = @previous_passage.waypoint_no
     sea_report_id = @previous_passage.sea_report_id


     @passage_plan = PassagePlan.new
     @passage_plan.update_attributes(waypoint_no: previous_waypoint + 1, sea_report_id: sea_report_id)
    else
      @passage_plan = PassagePlan.new
    end
  end

  # GET /passage_plans/1/edit
  def edit
  end

  # POST /passage_plans
  # POST /passage_plans.json
  def create

    @passage_plan = PassagePlan.new(params[:passage_plan])

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

    @passage_plan = PassagePlan.find(params[:id])

    if params[:new_sea_report]
      @sea_report_id = @passage_plan.sea_report_id
      @sea_report = SeaReport.find(@sea_report_id)

      # Same waypoint passage plan update
      @passage_wid_same_waypoints = @sea_report.passage_plans.where(:waypoint_no => @passage_plan.waypoint_no)

      if @passage_wid_same_waypoints.count > 1
       
        # Back passage plans update
        @bkward_passages = @sea_report.passage_plans.where("waypoint_no > ?", @passage_plan.waypoint_no)

        @bkward_passages.each do |bkward_passage|
        
          bkward_passage.update_attribute(:waypoint_no, bkward_passage.waypoint_no + 1)
        end

        @passage_wid_same_waypoints.each do |passage|
          unless passage.status == "new"
            passage.update_attribute(:waypoint_no, passage.waypoint_no + 1)
          end  
        end
      end
    end

    respond_to do |format|
      if @passage_plan.update(params[:passage_plan])

        @passage_plan.update_attribute(:status, "old")

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
    @passage_plan = PassagePlan.find(params[:id])
    @passage_plan.destroy
    @sea_report_id = @passage_plan.sea_report_id
    @sea_report = SeaReport.find(@sea_report_id)

    @bkward_passages = @sea_report.passage_plans.where("waypoint_no > ?", @passage_plan.waypoint_no)

    @bkward_passages.each do |bkwrd_passage|

      bkwrd_passage.update_attribute(:waypoint_no, bkwrd_passage.waypoint_no - 1)
    end

    respond_to do |format|
      format.html { redirect_to passage_plans_url, notice: 'Passage plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Create multiple Passage Plans
  def create_passage_plan
    passage_plans = params[:passage]
    passage_plans.each do |passage_plan|
      plan = PassagePlan.new(passage_plan)
      plan.update_attributes(:sea_report_id => params[:sea_report_id], :status => "old")
      plan.save
    end
    respond_to do |format|

     format.html { redirect_to edit_sea_report_path(params[:sea_report_id]), notice: 'Information updated successfully' }
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
