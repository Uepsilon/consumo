class DeliveriesController < ApplicationController

  def index
    @deliveries = Delivery.order('created_at DESC').all
  end

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new delivery_params
    @delivery.user = current_user

    if @delivery.save
      redirect_to :deliveries, notice: "Lieferung angelegt."
    else
      render :new
    end
  end

  def destroy
    begin
      @delivery = current_user.deliveries.find params[:id]
      @delivery.destroy

      redirect_to :deliveries, notice: "Lieferung gelöscht."
    rescue ActiveRecord::RecordNotFound
      redirect_to :deliveries, alert: "Spiel mit deinen eigenen Sachen!"
    end
  end

  private

  def delivery_params
    params.require(:delivery).permit(:product_id, :quantity, :price)
  end
end
