class Admin::PostsController < Admin::ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  def new
    @page_title = "Add Post"
    @post = Post.new
    @categories = Category.all
    @users = User.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "Post created"
      redirect_to admin_posts_path
    else
      render 'new'
    end
  end

  def edit
    @page_title = "Edit Post"
    @categories = Category.all
    @authors = Author.all
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post updated"
      redirect_to admin_posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post removed"
    redirect_to admin_posts_path
  end

  def index
    @posts = Post.all
  end

  private
    def set_post
      @post = Post.find(params[:id])
      
    end
    def post_params
      params.require(:post).permit(:title, :category_id, :user_id, :tags, :image, :body)
    end
end
