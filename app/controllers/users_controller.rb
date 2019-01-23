class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
        flash[:notice] = "You have signed up successfully!"
        redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.friendly.find(params[:id])
    @chables = @user.chables
    @following = @user.following
    @followers = @user.followers
  end

  def edit
  end 

  def update
    if @user.update_attributes(user_params)
        flash[:notice] = "Profile updated!"
        redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.friendly.find(params[:id]).destroy
    flash[:notice] = "Your Account is deleted from our database."
    redirect_to root_path
  end

  def following
    @title = "Following"
    @user  = User.friendly.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.friendly.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :username, :phone_number, :bio, :location, :birthday, :picture, :cover_picture)
  end

  def correct_user
    @user = User.friendly.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
