class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  def new
    @page_title = "Add Uuser"
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Cateogry created"
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def edit
    @page_title = "Edit User"
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User updated"
      redirect_to admin_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "User removed"
    redirect_to admin_users_path
  end

  def index
    @users = User.all
  end

  private
    def set_user
      @user = User.find(params[:id])
      
    end
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
