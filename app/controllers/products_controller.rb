class ProductsController < ApplicationController
  def index
    #@products = Product.order('category_id ASC').order('name ASC').all

    @filters = Product.order('category_id ASC').order('name ASC').search(params[:q])
    @products = @filters.result(distinct: true).paginate(page: params[:page])

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params

    if @product.save
      redirect_to :products, notice: "Produkt erstellt."
    else
      render :new
    end
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]

    if @product.update_attributes product_params
      redirect_to :products, notice: "Produkt geändert."
    else
      render :edit
    end
  end
  
  def search
    index
    render :index
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy

    redirect_to :products, notice: "Produkt gelöscht."
  end

  private

  def product_params
    params.require(:product).permit(:name, :category_id, :sku_id, :size, :picture)
  end
end
