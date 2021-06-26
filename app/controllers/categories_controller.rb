class CategoriesController < ApplicationController
  def show
    @category = Category.find_by_id(params[:id])
    @category_posts = @category.posts
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.name = @category.name.downcase

    if @category.save
      flash[:notice] = 'A new category was created.'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end