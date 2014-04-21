class BookingsController < ApplicationController

  def index  
    #@bookings = Booking.page(params[:page]).order('created_at DESC').all
    if not params[:q].nil? and not params[:q][:created_at_eq].nil? and not params[:q][:created_at_eq].empty?
      @q = Booking.order('created_at DESC').search(params[:q])
      @bookings = @q.result(:distinct => true).paginate(:page => params[:page]).send(params[:q][:created_at_eq])
      @period_value = params[:q][:created_at_eq]
    else
      @q = Booking.order('created_at DESC').search(params[:q])
      @bookings = @q.result(:distinct => true).paginate(:page => params[:page]) 
      @period_value = ""
    end

    @periods = {"Heute" => "today", "Gestern" => "yesterday", "Die letzten 7 Tage" => "past_week", "Die letzten 14 Tage" => "past_fortnight"}
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.new booking_params

    if @booking.save
      redirect_to :bookings, notice: "Buchung erfolgreich."
    else
      render :new
    end
  end

  def destroy
    begin
      @booking = current_user.bookings.find params[:id]
      @booking.destroy

      redirect_to :bookings, notice: "Buchung gelöscht."
    rescue ActiveRecord::RecordNotFound
      redirect_to :bookings, alert: "Spiel mit deinen eigenen Sachen!"
    end
  end

  def search
    index
    render :index
  end

  private

  def booking_params
    params.require(:booking).permit(:amount, :infotext, :receiver_id)
  end
end
