class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
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
    @booking = current_user.bookings.find params[:id]
    @booking.destroy

    redirect_to :bookings, notice: "Buchung gelöscht."
  end

  private

  def booking_params
    params.require(:booking).permit(:amount)
  end
end
