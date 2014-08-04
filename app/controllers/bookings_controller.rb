class BookingsController < ApplicationController

  def index
    @bookings = filter_and_pagination Booking
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.new booking_params
    @booking.realm = @current_realm

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
