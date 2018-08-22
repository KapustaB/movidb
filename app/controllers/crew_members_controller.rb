class CrewMembersController < ApplicationController
  before_action :set_actor, only: [:show, :edit, :update, :destroy]

  # GET /crew_members
  # GET /crew_members.json
  def index
    @crew_members = CrewMember.all
  end

  # GET /crew_members/1
  # GET /crew_members/1.json
  def show
  end

  # GET /crew_members/new
  def new
    @crew_member = CrewMember.new
  end

  # GET /crew_members/1/edit
  def edit
  end

  # POST /crew_members
  # POST /crew_members.json
  def create
    @crew_member = CrewMember.new(actor_params)

    respond_to do |format|
      if @crew_member.save
        format.html { redirect_to @crew_member, notice: 'CrewMember was successfully created.' }
        format.json { render :show, status: :created, location: @crew_member }
      else
        format.html { render :new }
        format.json { render json: @crew_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crew_members/1
  # PATCH/PUT /crew_members/1.json
  def update
    respond_to do |format|
      if @crew_member.update(actor_params)
        format.html { redirect_to @crew_member, notice: 'CrewMember was successfully updated.' }
        format.json { render :show, status: :ok, location: @crew_member }
      else
        format.html { render :edit }
        format.json { render json: @crew_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crew_members/1
  # DELETE /crew_members/1.json
  def destroy
    @crew_member.destroy
    respond_to do |format|
      format.html { redirect_to castMembers_url, notice: 'CrewMember was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actor
      @crew_member = CrewMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actor_params
      params.fetch(:crew_member, {})
    end
end
