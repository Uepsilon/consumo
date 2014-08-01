class OrderItemsController < ApplicationController

  rescue_from OrderItem::NotEnoughInventory, with: :not_enough_inventory

  def new
    @order_item = OrderItem.new
    @user = User.find(current_user.id)


    @last_delivery = @user.deliveries.current_realm(@realm.id).order('created_at DESC').first.product.title unless @user.deliveries.current_realm(@realm.id).empty?

    unless @user.orders.current_realm(@realm.id).empty?
      @last_order = @user.orders.current_realm(@realm.id).last.order_items.last.delivery.product.title
    else
      @last_order = t 'order_item.last_order_empty'
    end
    @bookings = @user.bookings.all
    @bookings_today = @user.bookings.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def create
    OrderItem.transaction do
      @order_item = OrderItem.new order_item_params
      @order = @order_item.build_order
      @order.build_booking user: current_user, realm: @realm

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
