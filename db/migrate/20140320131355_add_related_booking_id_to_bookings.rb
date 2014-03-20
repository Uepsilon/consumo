class AddRelatedBookingIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :booking_id, :integer
  end
end
