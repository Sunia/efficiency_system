class PassagePlansController < ApplicationController
  before_action :set_passage_plan, only: [:show, :edit, :update]

  # GET /passage_plans
  # GET /passage_plans.json
  def index

    if params[:sea_report_id]
      @sea_report = SeaReport.find(params[:sea_report_id])

      @closed_sea_report = @sea_report.is_closed
      @passage_plans = @sea_report.passage_plans
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
     @sea_report_id = @previous_passage.sea_report_id

     @passage_plan = PassagePlan.new
     @passage_plan.update_attributes(waypoint_no: previous_waypoint + 1, sea_report_id: @sea_report_id)
    else
      @passage_plan = PassagePlan.new
    end
  end

  # GET /passage_plans/1/edit
  def edit

    @passage_plan = PassagePlan.find(params[:id])
    @sea_report_id = @passage_plan.sea_report_id
    @sea_report = SeaReport.find(@sea_report_id)    
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
    @sea_report_id = @passage_plan.sea_report_id
    @sea_report = SeaReport.find(@sea_report_id)

    if params[:new_sea_report]

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
        # Check for start and end point true
        # then update the records of all other records
        start_point = @passage_plan.start_point
        end_point = @passage_plan.end_point
        update_start_end_point(start_point,end_point,@passage_plan.id, @sea_report_id )

        # Status is maintained to difference between new and old passage plan.
        @passage_plan.update_attribute(:status, "old")

        format.html { redirect_to passage_plans_path(:sea_report_id => @sea_report_id), notice: 'Passage plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @passage_plan }
      else
        format.html { render :edit }
        format.json { render json: @passage_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /passage_plans/1
  def destroy

    @passage_plan = PassagePlan.find(params[:id])
    @passage_plan.destroy
    sea_report_id = @passage_plan.sea_report_id
    sea_report = SeaReport.find(sea_report_id)

    @bkward_passages = sea_report.passage_plans.where("waypoint_no > ?", @passage_plan.waypoint_no)

    @bkward_passages.each do |bkwrd_passage|
      bkwrd_passage.update_attribute(:waypoint_no, bkwrd_passage.waypoint_no - 1)
    end

    respond_to do |format|
      format.html { redirect_to edit_sea_report_path(sea_report_id), notice: 'Waypoint is successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # Create multiple Passage Plans
  def create_passage_plan

    passage_plans = params[:passage]

    unless passage_plans.blank?

      passage_plans.each do |passage_plan|
        debugger
        plan = PassagePlan.new(passage_plan)
        plan.update_attributes(:sea_report_id => params[:sea_report_id], :status => "old")
        plan.save

        # Check for start and end point true for this plan
        # then update start/end to false of all other records
        update_start_end_point(plan.start_point, plan.end_point, plan.id ,params[:sea_report_id] )
      end
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

    # Update start and end point of other passage plans
    # if true of one passage_plan.
    def update_start_end_point(start_point,end_point, plan_id,sea_report_id )
      @sea_report = SeaReport.find(sea_report_id)
      passage_plans = @sea_report.passage_plans.where.not(id: plan_id)
 
      # Update start_point to false for all passage plans
      if start_point == true || start_point == "true"
        passage_plans.each {|plan| plan.update_attributes(:start_point => false )}
      end

      # Update end_point to false for all passage plans
      if end_point == "true" || end_point == true
        passage_plans.each {|plan| plan.update_attributes(:end_point => false )}
      end 
    end
end
