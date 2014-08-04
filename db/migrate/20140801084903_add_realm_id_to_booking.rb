class AddRealmIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :realm_id, :integer, :default => 1
  end
end
