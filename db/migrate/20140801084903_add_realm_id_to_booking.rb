class AddRealmIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :realm_id, :integer
  end
end
