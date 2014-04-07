class CategoriesController < ApplicationController
  def index
    @categories = Category.by_position.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to :categories, notice: "Kategorie erstellt."
    else
      render :new
    end
  end

  def edit
    @category = Category.find params[:id]
  end

  def update
    @category = Category.find params[:id]

    if @category.update_attributes category_params
      redirect_to :categories, notice: "Kategorie geändert."
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy

    redirect_to :categories, notice: "Kategorie gelöscht."
  end

  private

  def category_params
    params.require(:category).permit(:title, :position)
  end
end
