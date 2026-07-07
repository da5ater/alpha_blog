class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[
        :notice
      ] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up."
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      flash.now[:alert] = "There was an error creating the user."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated."
      redirect_to articles_path
    else
      flash.now[
        :alert
      ] = "There was an error updating your account information."
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @articles = @user.articles
  end

  def index
    @pagy, @users = pagy(User.order(created_at: :desc), limit: 5)
  end

  def destroy
    @user.destroy
    if @user == current_user
      session[:user_id] = nil
      flash[
        :notice
      ] = "Your account and all associated articles have been successfully deleted."
      redirect_to root_path
    else
      flash[
        :notice
      ] = "User and all associated articles have been successfully deleted."
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own account."
      redirect_to articles_path
    end
  end
end
