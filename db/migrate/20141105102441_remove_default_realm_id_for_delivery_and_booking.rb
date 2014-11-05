class RemoveDefaultRealmIdForDeliveryAndBooking < ActiveRecord::Migration
  def change
    change_column_default :deliveries, :realm_id, nil
    change_column_default :bookings, :realm_id, nil
  end
end
