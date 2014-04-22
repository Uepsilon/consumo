class OrdersController < ApplicationController

  def index
    @filters = Order.order('created_at DESC').search(params[:q])
    @orders = @filters.result(distinct: true).paginate(page: params[:page])
    @orders = @orders.send(created_at_eq) unless created_at_eq.blank?
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
