class OrdersController < ApplicationController

  def index 
    if not params[:q].nil? and not params[:q][:created_at_eq].nil? and not params[:q][:created_at_eq].empty?
      @q = Order.order('created_at DESC').search(params[:q])   
      @orders = @q.result(:distinct => true).paginate(:page => params[:page]).send(params[:q][:created_at_eq])
      @period_value = params[:q][:created_at_eq]
    else
      @q = Order.order('created_at DESC').search(params[:q])
      @orders = @q.result(:distinct => true).paginate(:page => params[:page]) 
      @period_value = ""
    end
    @periods = {"Heute" => "today", "Gestern" => "yesterday", "Die letzten 7 Tage" => "past_week", "Die letzten 14 Tage" => "past_fortnight"}
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
