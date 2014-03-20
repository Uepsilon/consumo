class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
    if not params[:user_id].nil? and User.find(params[:user_id])
      @bookings = @bookings.where(user_id: params[:user_id])
      flash.now[:notice] = I18n.t "bookings.by", name: User.find(params[:user_id]).name
    end
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

  private

  def booking_params
    params.require(:booking).permit(:amount, :infotext)
  end
end
