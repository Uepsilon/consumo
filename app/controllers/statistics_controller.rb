class StatisticsController < ApplicationController

  def index  
    @orders   = Order.all
    @bookings = Booking.all
  end
end
