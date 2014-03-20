class OrderItemsController < ApplicationController

  def new
    @order_item = OrderItem.new
  end

  def create
    OrderItem.transaction do
      @order_item = OrderItem.new order_item_params
      @order = @order_item.build_order
      @order.build_booking user: current_user

      if @order_item.save
        redirect_to :new_order_item, notice: "PROST!"
      else
        redirect_to :new_order_item, alert: "ALARM... ALAAAAAAAAAAAAAAAAAAAAAAARM!"
      end
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:delivery_id, :amount)
  end
end
