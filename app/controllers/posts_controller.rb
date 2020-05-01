class PostsController < ApplicationController
  before_action :set_variables

  def index
    if params[:search]
      @posts = Post.search(params[:search]).order('created_at DESC').paginate(per_page: 3, page: params[:page])
    else
      @posts = Post.all.order("created_at DESC").paginate(per_page: 3, page: params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all
    puts "*****************************"
    p @post.comments
    p @post.comments.length
    puts "*****************************"

  end

  private
    def set_variables
      @categories = Category.all
    end
end
