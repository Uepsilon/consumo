class DeliveriesController < ApplicationController

  def index

    @filters = Delivery.order('created_at DESC').search(params[:q])
    
    if not params[:q].nil? and not params[:q][:created_at_eq].nil? and not params[:q][:created_at_eq].empty?
      @deliveries = @filters.result(distinct: true).paginate(page: params[:page]).send(params[:q][:created_at_eq])
      @period_value = params[:q][:created_at_eq]
    else
      @deliveries = @filters.result(distinct: true).paginate(page: params[:page]) 
      @period_value = ""
    end

    @periods = {"Heute" => "today", "Gestern" => "yesterday", "Die letzten 7 Tage" => "past_week", "Die letzten 14 Tage" => "past_fortnight"}
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

  def search
    index
    render :index
  end

  private

  def delivery_params
    params.require(:delivery).permit(:product_id, :quantity, :price)
  end
end
