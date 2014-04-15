class OrdersController < ApplicationController

  def index 
    @q = Order.search(params[:q])
    @orders = @q.result(distinct: true)
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

  def search
    index
    render :index
  end
  private
end
