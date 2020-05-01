class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @posts = @category.posts #.order("created_at DESC").paginate(per_page: 3, page: params[page])
  end
end
