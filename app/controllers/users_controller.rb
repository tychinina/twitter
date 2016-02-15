class UsersController < ApplicationController
  
  before_action :sign_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]


  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Данные изменены"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def sign_in_user
      unless signed_in?
        flash[:danger] = "Необходимо пройти авторизацию"
        store_location
        redirect_to signin_path
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end