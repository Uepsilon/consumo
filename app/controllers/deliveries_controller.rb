class DeliveriesController < ApplicationController

  def index
    @deliveries = filter_and_pagination Delivery
  end

  def new
    @delivery = Delivery.new
  end

  def create
    @delivery = Delivery.new delivery_params
    @delivery.build_booking user: current_user, amount: @delivery.price

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

  def search
    index
    render :index
  end

  private

  def delivery_params
    params.require(:delivery).permit(:product_id, :quantity, :price, :realm_id)
  end
end
