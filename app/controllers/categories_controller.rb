class CategoriesController < ApplicationController
  before_action :require_admin, only: %i[new create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created successfully."
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    @pagy, @articles =
      pagy(
        @category
          .articles
          .includes(:user, :categories)
          .order(created_at: :desc),
        limit: 5
      )
  end

  def index
    @pagy, @categories = pagy(Category.all)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category was updated successfully."
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "Only admin users can perform that action."
      redirect_to categories_path
    end
  end
end


