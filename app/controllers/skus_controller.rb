class SkusController < ApplicationController
  def index
    @skus = Sku.order('title ASC').all
  end

  def new
    @sku = Sku.new
  end

  def create
    @sku = Sku.new sku_params

    if @sku.save
      redirect_to :skus, notice: "Produkt erstellt."
    else
      render :new
    end
  end

  def edit
    @sku = Sku.find params[:id]
  end

  def update
    @sku = Sku.find params[:id]

    if @sku.update_attributes sku_params
      redirect_to :skus, notice: "Produkt geändert."
    else
      render :edit
    end
  end

  def destroy
    @sku = Sku.find params[:id]
    @sku.destroy

    redirect_to :skus, notice: "Produkt gelöscht."
  end

  private

  def sku_params
    params.require(:sku).permit(:title, :short)
  end
end
