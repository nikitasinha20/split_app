class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
  end

  #def show
  #  @current_user = User.find(params[:id])
  #end

  def new
    @user = User.new
  end

  def edit
  end

  def home
    @current_user = current_user
  end

  def login
    current_user = session[:current_user_id] = nil
  end

  def login_attempt
    user = User.authenticate(params[:email],params[:password])
    if user
      session[:current_user_id] = user.id 
      redirect_to users_home_path(user) 
    else
      render "login", :alert => 'Incorrect email or password' 
    end
  end

  def create
    @user = User.new(user_params)
    session[:current_user_id] = @user.id 
    if $list.keys.include? (@user.email)
      Group.find($list[@user.email]).users << @user
      $list.delete(@user.email)
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to :action => 'login' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to :action => 'login' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
