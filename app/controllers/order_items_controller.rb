class OrderItemsController < ApplicationController
  rescue_from OrderItem::NotEnoughInventory, with: :not_enough_inventory

  def new
    @order_item = OrderItem.new
    @last_delivery = current_user.last_delivery
    @last_order = current_user.last_ordered_product

    @bookings = current_user.bookings.by_realm(current_user.current_realm_id)
    @bookings_today = @bookings.where('created_at >= ?', Time.zone.now.beginning_of_day)
  end

  def create
    OrderItem.transaction do
      @order_item = OrderItem.new order_item_params
      @order = @order_item.build_order
      @order.build_booking user: current_user

      if @order_item.save
        redirect_to :new_order_item, notice: "Consumo sagt, #{@order_item.delivery.product.name} gebucht. Hai!"
      else
        redirect_to :new_order_item, alert: 'Consumo sagt, nix gut.'
      end
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:delivery_id, :amount)
  end

  private

  def not_enough_inventory
    redirect_to :new_order_item, alert: 'Consumo sagt, wir nix genug Zeug da!'
  end
end
