class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  def new
    @page_title = "Add User"
    @user = User.new
  end

  def create
    # @user = User.new(user_params)
    password_salt_value = BCrypt::Engine.generate_salt
    password_hash_value = BCrypt::Engine.hash_secret(params[:user][:password], password_salt_value)
    @user = User.new({name: params[:user][:name], email: params[:user][:email], password_salt: password_salt_value, password_hash: password_hash_value})
    if @user.save!
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
    password_salt_value = BCrypt::Engine.generate_salt
    password_hash_value = BCrypt::Engine.hash_secret(params[:user][:password], password_salt_value)
    if @user.update({name: params[:user][:name], email: params[:user][:email], password_salt: password_salt_value, password_hash: password_hash_value})
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
    if params[:search]
      @users = User.search(params[:search]).all.order('created_at DESC').paginate(per_page: 3, page: params[:page])
    else
      @users = User.all.order('created_at DESC').paginate(per_page: 3, page: params[:page])
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
      
    end
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
