class OrderItemsController < ApplicationController

  def new
    @order_item = OrderItem.new
    @user = User.find(current_user.id)
    @last_delivery = @user.deliveries.order('created_at DESC').first.product.title unless @user.deliveries.empty?

    if not @user.orders.empty?
      @last_order = @user.orders.last.order_items.last.delivery.product.title
    else
      @last_order = t 'order_item.last_order_empty'
    end
    get_calories_today
    @bookings = @user.bookings.all
    @bookings_today = @user.bookings.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

  def get_calories_today
    @calories_today = 0
    current_user.orders.today.each do |order| 
      order.order_items.each do |order_item| 
        @calories_today += order_item.delivery.product.calories 
      end 
    end
    @calories_today
  end

  def create
    OrderItem.transaction do
      @order_item = OrderItem.new order_item_params
      @order = @order_item.build_order
      @order.build_booking user: current_user

      if @order_item.save
        redirect_to :new_order_item, notice: "Consumo sagt, #{@order_item.delivery.product.name} gebucht. Hai!"
      else
        redirect_to :new_order_item, alert: "Consumo sagt nix gut"
      end
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:delivery_id, :amount)
  end
end
