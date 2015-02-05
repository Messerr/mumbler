class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show, :destroy, :following, :followers]
	
  def index
  	@users = User.all
    if current_user 
      redirect_to posts_path
    else
      
    end

  end

  def new
  	@user = User.new
  end

  def edit
  end

  def show
  end

  def create
  	@user = User.create(user_params)
    session[:user_id] = @user.id
  	redirect_to @user, notice: "New user created."

  end

  def update
  	@user.update(user_params)
  	redirect_to @user, notice: "User successfully updated."
  end

  def destroy
  	@user.destroy
  	redirect_to users_path, notice: "User was deleted."
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def set_user
  	@user = User.find(params[:id])
  end

def user_params
    params.require(:user).permit(:name, :bio, :email, :password)
  end

end
