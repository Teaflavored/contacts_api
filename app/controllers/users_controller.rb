class UsersController < ApplicationController
  before_action :ensure_logged_in, except: [:new]

  def index
    @users = User.all
  end
  
  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to users_url
    else
      flash.now.notice = @user.errors.full_messages
      render 'new'
    end
  end
  
  def show
    @user = current_user
  end
  
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render(json: user.errors.full_messages, status: :unprocessable_entity)
    end
  end
  
  def destroy
    user = User.find(params[:id])
    user.destroy!
    render json: user
  end
  
  def favorites
    @user = User.find(params[:user_id])
    @favorite_contacts = @user.favorite_contacts
  end
  
  private
    
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def ensure_logged_in
    redirect_to new_session_url if current_user.nil?
  end
end
