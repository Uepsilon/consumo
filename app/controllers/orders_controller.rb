class OrdersController < ApplicationController

  def index  
    @orders = Order.page(params[:page]).order('created_at DESC').all
  end

  def destroy
    begin
      @order = current_user.orders.find params[:id]
      @order.destroy

      redirect_to :orders, notice: "Bestellug gelöscht."
    rescue ActiveRecord::RecordNotFound
      redirect_to :orders, alert: "Spiel mit deinen eigenen Sachen!"
    end
  end

  private
end
