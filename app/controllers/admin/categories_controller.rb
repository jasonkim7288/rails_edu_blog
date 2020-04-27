class Admin::CategoriesController < Admin::ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  def new
    @page_title = "Add Category"
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    puts "****************"
    p @category
    puts "****************"
    if @category.save
      flash[:notice] = "Cateogry created"
      redirect_to admin_categories_path
    else
      render 'new'
    end
  end

  def edit
    @page_title = "Edit Category"
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated"
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category removed"
    redirect_to admin_categories_path
  end

  def index
    @categories = Category.all
  end

  private
    def set_category
      @category = Category.find(params[:id])
      
    end
    def category_params
      params.require(:category).permit(:name)
    end
end
