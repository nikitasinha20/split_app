class GroupsController < ApplicationController

  def show
  	@current_user = current_user
  end

  def new
    @current_user = current_user
    @group = Group.new
    @users = User.all
  end 

  def edit
  	@group = Group.find(params[:id])
  	@current_user = current_user
  end

  def create
    @group = current_user.groups.new(group_params)
 
    respond_to do |format|
      if @group.save
        format.html { redirect_to  @group }
        format.json { render json: @group, status: :created, location: [current_user,@group] }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def home
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to :action => "show"}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_to do |format|
      format.html { redirect_to group_url }
      format.json { head :no_content }
    end
  end

  def invite
    @group = Group.find(params[:id])
  end

  def send_invite
    Group.invite(params[:id], params[:email]) 

    respond_to do |format|
      format.html { redirect_to :action => "show"} 
      format.json { head :no_content }
    end
  end

  private
    def set_group
      @group = current_user.groups.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :user_ids => [])
    end
end
